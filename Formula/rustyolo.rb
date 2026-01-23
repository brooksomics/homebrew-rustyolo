# Homebrew Formula for RustyYOLO
# This formula should be placed in a separate tap repository: brooksomics/homebrew-rustyolo
# Usage: brew install brooksomics/rustyolo/rustyolo

class Rustyolo < Formula
  desc "Secure, firewalled wrapper for running AI agents in YOLO mode"
  homepage "https://github.com/brooksomics/llm-rustyolo"
  version "0.5.1"  # Update this when creating new releases
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-apple-darwin.tar.gz"
      sha256 "sha256:63318b52fdf973c3c7f81673119e49c0d6d50d4fe2f68daaa9076e7f5cbc30a3"  # Calculate with: shasum -a 256 rustyolo-x86_64-apple-darwin.tar.gz
    elsif Hardware::CPU.arm?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-aarch64-apple-darwin.tar.gz"
      sha256 "sha256:026fc1ac643de34e699b3aae919f4cca75efd7fcf030940d3a93f18e723cd874"  # Calculate with: shasum -a 256 rustyolo-aarch64-apple-darwin.tar.gz
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "sha256:66ca29a8d8a48ebdac314c772438c2b0b36f55adb54ac9b06aa1f3d3ae9b1089"  # Calculate with: shasum -a 256 rustyolo-x86_64-unknown-linux-gnu.tar.gz
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
