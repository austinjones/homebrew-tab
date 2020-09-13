class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.3.2.tar.gz"
  sha256 "4b988a23189213ed4826236faee2c9b893ba947a062ce92e965b43d78bae7c88"
  license "MIT"
  revision 10
  head "https://github.com/austinjones/tab-rs.git"

  bottle do
    root_url "https://dl.bintray.com/austinjones/bottles-taps"
    cellar :any_skip_relocation
    sha256 "44399efd5bd66839866c35f04eefa65e52ceaf52d78c3f70e3da1b45f956cb34" => :catalina
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
    assert_equal "tab 0.3.2\n", shell_output("#{bin}/tab -V")
  end
end
