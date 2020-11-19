class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.5.1.tar.gz"
  sha256 "47a2b027b8f964a80d4f774d5f85294ecd8eb945084a2ef3022d8ba2fd1b58f1"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"
  # rebuild

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.5.1"
    cellar :any_skip_relocation
    rebuild 2
    sha256 "c5cd006620185ec42db1ef7baa2f85d0cc0ebcea191b77fa6e5652561ed8639d" => :catalina
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
    # TODO: add some kind of test assertion that is compatible with the automated bump script
    # assert_equal "tab 0.3.2\n", shell_output("#{bin}/tab -V")
  end
end
