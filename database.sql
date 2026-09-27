CREATE TABLE IF NOT EXISTS garden_trading_hub (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    plant_type VARCHAR(50) NOT NULL,
    growth_stage INT NOT NULL,
    planted_at TIMESTAMP NOT NULL,
    booth_id INT,
    last_claimed TIMESTAMP
);

INSERT INTO garden_trading_hub (player_id, plant_type, growth_stage, planted_at) VALUES
(1, 'Tomato', 0, NOW()),
(2, 'Carrot', 0, NOW());