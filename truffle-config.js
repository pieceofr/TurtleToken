module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  QA: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "3" // Ropsten Test Net
    }
  },
  Production: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "1" // Match any network id
    }
  }
};
