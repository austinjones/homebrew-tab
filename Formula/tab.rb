class Tab < Formula
  desc "A modern terminial multiplexer designed for software & systems engineers"
  homepage "https://github.com/austinjones/tab-rs"
  url "https://github.com/austinjones/tab-rs/archive/v0.3.0.tar.gz"
  sha256 "fe021a7526b7c25bbd0cc577ee6c4d83498b3193e1bd9dbbc921efab71d37814"
  license "MIT"
  revision 1
  head "https://github.com/austinjones/tab-rs.git"

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
