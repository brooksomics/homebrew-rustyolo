# Homebrew Formula for RustyYOLO
# This formula should be placed in a separate tap repository: brooksomics/homebrew-rustyolo
# Usage: brew install brooksomics/rustyolo/rustyolo

class Rustyolo < Formula
  desc "Secure, firewalled wrapper for running AI agents in YOLO mode"
  homepage "https://github.com/brooksomics/llm-rustyolo"
  version "0.3.1"  # Update this when creating new releases
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.3.1/rustyolo-x86_64-apple-darwin.tar.gz"
      sha256 "036cd605572256345e85c4c47b89ee8e997d979f98a2af7bf5e9af9d8f55f447"  # Calculate with: shasum -a 256 rustyolo-x86_64-apple-darwin.tar.gz
    elsif Hardware::CPU.arm?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.3.1/rustyolo-aarch64-apple-darwin.tar.gz"
      sha256 "6b9204a636551d5baa85106784358ddc79636b32d114f1f241ef42a5a97d8029"  # Calculate with: shasum -a 256 rustyolo-aarch64-apple-darwin.tar.gz
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v0.3.1/rustyolo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4139d9307d9577b46181c2a38b1f139393fdb41ad74610e44732045269c25714"  # Calculate with: shasum -a 256 rustyolo-x86_64-unknown-linux-gnu.tar.gz
    end
  end

  # Dependencies
  depends_on "docker"

  def install
    bin.install "rustyolo"
  end

  def caveats
    <<~EOS
      RustyYOLO requires Docker to run AI agents in isolated containers.

      To get started:
        1. Ensure Docker is running
        2. Build the Docker image (first time only):
           cd #{opt_prefix} && docker build -t llm-rustyolo:latest .

      Or pull from a registry (if published):
           docker pull ghcr.io/brooksomics/llm-rustyolo:latest

      Usage:
        rustyolo --help
        rustyolo --allow-domains "github.com pypi.org" claude

      Update the CLI:
        brew upgrade rustyolo

      Update the Docker image:
        rustyolo update --image
    EOS
  end

  test do
    assert_match "rustyolo", shell_output("#{bin}/rustyolo --version")
  end
end
