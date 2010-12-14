require 'formula'

class Winetricks < ScriptFileFormula
  url 'http://winezeug.googlecode.com/svn-history/r1987/trunk/winetricks', :using => :curl
  homepage 'http://wiki.winehq.org/winetricks'
  version '20101106'

  head 'http://winezeug.googlecode.com/svn/trunk/winetricks', :using => :curl

  if ARGV.build_head?
    md5 'c42ee409c7c4b71dfd4ee326aab8e14c'
  else
    md5 '912b829ec55c0e3634f1577a67ce3277'
  end

  def caveats; <<-EOS.undent
    winetricks is a set of utilities for wine, which is installed separately:
      brew install wine
    EOS
  end
end
