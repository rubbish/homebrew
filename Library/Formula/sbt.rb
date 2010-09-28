require 'formula'

class Sbt <Formula
  JAR = 'sbt-launch-0.7.4.jar'
  url "http://simple-build-tool.googlecode.com/files/#{JAR}"
  homepage 'http://code.google.com/p/simple-build-tool/'
  md5 '8903fb141037056a497925f3efdb9edf'

  def install
    (bin+'sbt').write <<-EOS
#!/bin/sh
java -XX:MaxPermSize=256m -XX:+CMSClassUnloadingEnabled -Xss2M -Xmx1024M -jar #{libexec}/#{JAR} "$@"
EOS

    libexec.install Dir['*']
  end
end
