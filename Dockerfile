# Use an official Ruby image
FROM ruby:3.3.4

# Set working directory
WORKDIR /rails


# Install additional dependencies for Rails (PostgreSQL, etc.)
RUN apt-get update -qq && \
apt-get install --no-install-recommends -y \
build-essential \
curl \
git \
libjemalloc2 \
libvips \
postgresql-client && \
rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Set environment to development
ENV RAILS_ENV=development

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["sh", "-c", "rm -f /rails/tmp/pids/server.pid && rails server -b 0.0.0.0 -p 3000"]

