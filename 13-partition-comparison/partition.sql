EXPLAIN ANALYSE SELECT
 AVG(fuel_level_pct)
FROM
 iot.vehicle_sensor_data;


EXPLAIN ANALYSE SELECT
 AVG(fuel_level_pct)
FROM
 iot.vehicle_sensor_data_partitioned;

EXPLAIN ANALYSE SELECT
 vehicle_id,
 date_trunc('hour', timestamp) AS hour_slot,
 AVG(speed_kph) AS avg_speed,
 AVG(fuel_level_pct) AS avg_fuel_level
FROM iot.vehicle_sensor_data
WHERE timestamp >= '2025-02-15 00:00:00'::timestamp - INTERVAL '24 hours'
GROUP BY vehicle_id, hour_slot
ORDER BY vehicle_id, hour_slot;

EXPLAIN ANALYSE SELECT
 vehicle_id,
 date_trunc('hour', timestamp) AS hour_slot,
 AVG(speed_kph) AS avg_speed,
 AVG(fuel_level_pct) AS avg_fuel_level
FROM iot.vehicle_sensor_data_partitioned
WHERE timestamp >= '2025-02-15 00:00:00'::timestamp - INTERVAL '24 hours'
GROUP BY vehicle_id, hour_slot
ORDER BY vehicle_id, hour_slot;

EXPLAIN ANALYSE SELECT
 vehicle_id,
 timestamp,
 engine_temp_celsius,
 AVG(engine_temp_celsius) OVER (
	PARTITION BY vehicle_id
	ORDER BY timestamp
	ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING
 ) AS moving_avg_temp
FROM iot.vehicle_sensor_data
WHERE engine_temp_celsius > 150
 AND timestamp >= '2025-02-15 00:00:00'::timestamp - INTERVAL '7 days'
ORDER BY timestamp;

EXPLAIN ANALYSE SELECT
 vehicle_id,
 timestamp,
 engine_temp_celsius,
 AVG(engine_temp_celsius) OVER (
	PARTITION BY vehicle_id
	ORDER BY timestamp
	ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING
 ) AS moving_avg_temp
FROM iot.vehicle_sensor_data_partitioned
WHERE engine_temp_celsius > 150
 AND timestamp >= '2025-02-15 00:00:00'::timestamp - INTERVAL '7 days'
ORDER BY timestamp;
