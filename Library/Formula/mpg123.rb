require 'formula'

class Mpg123 <Formula
  url 'http://downloads.sourceforge.net/project/mpg123/mpg123/1.12.5/mpg123-1.12.5.tar.bz2'
  homepage 'http://www.mpg123.de/'
  md5 '01fa64533cade452c2b22a3ce14a2fcd'

  def skip_clean? path
    # mpg123 can't find its plugins if there are no la files
    path.extname == '.la'
  end

  def install
    args = ["--disable-debug", "--disable-dependency-tracking",
            "--with-optimization=4",
            "--prefix=#{prefix}",
            "--with-audio=coreaudio",
            "--with-default-audio=coreaudio"]

    if snow_leopard_64?
      args << "--with-cpu=x86-64"
    else
      args << "--with-cpu=sse_alone"
    end

    system "./configure", *args

    # ./configure incorrectly detects 10.5 as 10.4; fix it.
    ['.', 'src', 'src/output', 'src/libmpg123'].each do |path|
      inreplace "#{path}/Makefile" do |s|
        s.gsub! "-mmacosx-version-min=10.4 -isysroot /Developer/SDKs/MacOSX10.4u.sdk", ""
        s.change_make_var! "LDFLAGS", "-Wl,-read_only_relocs,suppress"
      end
    end

    system "make install"
  end
end
