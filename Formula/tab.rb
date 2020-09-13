class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.3.3.tar.gz"
  sha256 "8724aa7f4daa7b16bfe01a6d59b97914746cb3c7ffc7f3047e6bae3afed52e56"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.3.2"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "69ad9358b706c45cd5a4c598e4ff734ca997197d3fa51daa7e67e79b8cc6ec14" => :catalina
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
