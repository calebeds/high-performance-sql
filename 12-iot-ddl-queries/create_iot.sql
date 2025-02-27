
CREATE TABLE iot.vehicle_sensor_data (
    vehicle_id TEXT NOT NULL,  -- VIN number
    sensor_id TEXT NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    speed_kph DECIMAL(5,2) NOT NULL,  -- Current speed in kilometers per hour
    fuel_level_pct DECIMAL(4,1) NOT NULL,  -- Fuel level percentage
    engine_temp_celsius DECIMAL(5,2) NOT NULL,  -- Engine temperature
    tire_pressure_kpa DECIMAL(4,1) NOT NULL,  -- Tire pressure in kilopascals
    battery_voltage DECIMAL(3,1) NOT NULL,  -- Battery voltage
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Composite primary key
    PRIMARY KEY (vehicle_id, sensor_id, timestamp)
);

-- Index for efficient time-series queries
CREATE INDEX idx_vehicle_sensor_sensor ON iot.vehicle_sensor_data(sensor_id);
CREATE INDEX idx_vehicle_sensor_timestamp ON iot.vehicle_sensor_data(timestamp);



--- Partitioned Version
CREATE TABLE iot.vehicle_sensor_data_partitioned (
    sensor_id TEXT NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vehicle_id TEXT NOT NULL,
    speed_kph DECIMAL(5,2) NOT NULL,
    fuel_level_pct DECIMAL(4,1) NOT NULL,
    engine_temp_celsius DECIMAL(5,2) NOT NULL,
    tire_pressure_kpa DECIMAL(4,1) NOT NULL,
    battery_voltage DECIMAL(3,1) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Composite primary key
    PRIMARY KEY (vehicle_id, sensor_id, timestamp)

) PARTITION BY RANGE (timestamp);

-- Create partitions for each month
CREATE TABLE iot.vehicle_sensor_data_202501 PARTITION OF iot.vehicle_sensor_data_partitioned
    FOR VALUES FROM ('2025-01-01 00:00:00') TO ('2025-02-01 00:00:00');

CREATE TABLE iot.vehicle_sensor_data_202502 PARTITION OF iot.vehicle_sensor_data_partitioned
    FOR VALUES FROM ('2025-02-01 00:00:00') TO ('2025-03-01 00:00:00');

CREATE TABLE iot.vehicle_sensor_data_202503 PARTITION OF iot.vehicle_sensor_data_partitioned
    FOR VALUES FROM ('2025-03-01 00:00:00') TO ('2025-04-01 00:00:00');

-- Create indexes on partitioned table
CREATE INDEX idx_vehicle_sensor_sensor_part ON iot.vehicle_sensor_data_partitioned(sensor_id);
CREATE INDEX idx_vehicle_sensor_timestamp_part ON iot.vehicle_sensor_data_partitioned(timestamp);

