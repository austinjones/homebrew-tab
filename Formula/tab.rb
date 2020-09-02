class Tab < Formula
  desc "A modern terminial multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/0.2.2.tar.gz"
  sha256 "237e5daf541922991affb729eb5c6f3d62223aad6da22ece975c26ce72720c1d"
  license "MIT"
  revision 1
  head "https://github.com/austinjones/tab-rs.git"

  bottle do
    root_url "https://dl.bintray.com/austinjones/bottles-taps"
    cellar :any_skip_relocation
    sha256 "8a1f7b3d0afcc4890f23af91236c75ebf103cbf76d2db92b44ba44f19a8f10c1" => :catalina
  end

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    system "cargo", "install", "--path", "tab/", "--locked", "--root", prefix

    bash_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "bash")
    (bash_completion/"tab").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "zsh")
    (zsh_completion/"_tab").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/tab", "--completion", "fish")
    (fish_completion/"tab.fish").write fish_output
  end

  test do
    assert_equal "tab v0.2\n", shell_output("#{bin}/tab -V")
  end
end
