# Homebrew Formula for RustyYOLO
# This formula should be placed in a separate tap repository: brooksomics/homebrew-rustyolo
# Usage: brew install brooksomics/rustyolo/rustyolo

class Rustyolo < Formula
  desc "Secure, firewalled wrapper for running AI agents in YOLO mode"
  homepage "https://github.com/brooksomics/llm-rustyolo"
  version "0.5.0"  # Update this when creating new releases
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-apple-darwin.tar.gz"
      sha256 "sha256:5f57581f61a06fa7297ec4a139542ce9191f2107aca0acee00424a62ee5783a1"  # Calculate with: shasum -a 256 rustyolo-x86_64-apple-darwin.tar.gz
    elsif Hardware::CPU.arm?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-aarch64-apple-darwin.tar.gz"
      sha256 "sha256:5a9fe2e4bc1fd15934d343e6de4fe16b07885490f94a75e929d3fc3bf9572a61"  # Calculate with: shasum -a 256 rustyolo-aarch64-apple-darwin.tar.gz
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/brooksomics/llm-rustyolo/releases/download/v#{version}/rustyolo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "sha256:cabd2e34e8fd6ed6af91d259c25a14f3a1f6e58e4f84a5092bd17dc8c132b174"  # Calculate with: shasum -a 256 rustyolo-x86_64-unknown-linux-gnu.tar.gz
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
