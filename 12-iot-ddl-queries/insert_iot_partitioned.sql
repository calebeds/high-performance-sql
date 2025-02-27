INSERT INTO iot.vehicle_sensor_data_partitioned (
    sensor_id,
    timestamp,
    vehicle_id,
    speed_kph,
    fuel_level_pct,
    engine_temp_celsius,
    tire_pressure_kpa,
    battery_voltage,
    created_at
)
SELECT 
    sensor_id,
    timestamp,
    vehicle_id,
    speed_kph,
    fuel_level_pct,
    engine_temp_celsius,
    tire_pressure_kpa,
    battery_voltage,
    created_at
FROM iot.vehicle_sensor_data
WHERE timestamp >= '2025-01-01 00:00:00' 
  AND timestamp < '2025-04-01 00:00:00';
