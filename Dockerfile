# Use an official Ruby image
FROM ruby:3.3.4

# Set working directory
WORKDIR /rails

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install additional dependencies for Rails (PostgreSQL, etc.)
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y \
  curl \
  libjemalloc2 \
  libvips \
  postgresql-client \
  git \
  build-essential && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

  # Set environment to development
ENV RAILS_ENV=development

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

