class Tab < Formula
  desc "The intuitive, config-driven terminal multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.3.4.tar.gz"
  sha256 "dc11f9f5cd62de7ee27762d96210623ef91ead2b490eb3c2eae94bd52a344de0"
  license "MIT"
  head "https://github.com/austinjones/tab-rs.git"

  bottle do
    root_url "https://github.com/austinjones/tab-rs/releases/download/v0.3.4"
    cellar :any_skip_relocation
    sha256 "e72379609b182c22f23df2ef45a61170533eea2d85c327bbe4e821aaa6857eb0" => :catalina
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
