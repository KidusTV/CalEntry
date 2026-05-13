import 'dart:math';

// ─────────────────────────────────────────────────────────────────────────────
// Physik-Konstanten
// ─────────────────────────────────────────────────────────────────────────────

const double kSpring      = 18.0; // Federstärke
const double kDamping     = 7.0;  // Dämpfung
const double kMaxTilt     = 0.38; // max. Neigung ~22°
const double kMaxRoll     = pi;   // volle 360°-Kreisrotation
const double kFlashDuration = 1.2; // Sekunden für den Ziel-Ring-Flash

// ─────────────────────────────────────────────────────────────────────────────
// Spring-Damper Integrator
// ─────────────────────────────────────────────────────────────────────────────

/// Integriert einen einzelnen Freiheitsgrad (Winkel + Geschwindigkeit) mit
/// einem kritisch gedämpften Federsystem.
///
/// [target]    → Zielwert
/// [angle]     → aktueller Winkel
/// [velocity]  → aktuelle Winkelgeschwindigkeit
/// [maxAngle]  → Clamp-Grenze (nur wenn [wrapAngle] == false)
/// [wrapAngle] → bei true: Wrap-Around über ±π (für Kreisrotation)
///
/// Gibt `(newAngle, newVelocity)` zurück.
(double angle, double velocity) integrateSpring({
  required double target,
  required double angle,
  required double velocity,
  required double maxAngle,
  required bool wrapAngle,
  required double dt,
}) {
  double error = angle - target;

  if (wrapAngle) {
    while (error >  pi) error -= 2 * pi;
    while (error < -pi) error += 2 * pi;
  }

  final acc = -kSpring * error - kDamping * velocity;
  velocity += acc * dt;
  angle    += velocity * dt;

  if (!wrapAngle) angle = angle.clamp(-maxAngle, maxAngle);

  return (angle, velocity);
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Spring (kritisch gedämpft, für Wasserstand)
// ─────────────────────────────────────────────────────────────────────────────

const double _kProgressSpeed   = 6.0;
const double _kProgressDamping = 2.0 * _kProgressSpeed; // kritisch gedämpft

/// Gibt `(newDisplayedProgress, newVelocity)` zurück.
(double displayed, double velocity) integrateProgress({
  required double target,
  required double displayed,
  required double velocity,
  required double dt,
}) {
  final dif = target - displayed;
  velocity += (_kProgressSpeed * _kProgressSpeed * dif
      - _kProgressDamping * velocity) * dt;
  displayed += velocity * dt;

  if (dif.abs() < 0.0005 && velocity.abs() < 0.001) {
    return (target, 0.0);
  }

  return (displayed, velocity);
}