import Foundation

struct Point {
    let x: Double
    let y: Double

    // Функція для обчислення евклідової відстані між поточною точкою та заданою точкою
    func distance(to point: Point) -> Double {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(dx * dx + dy * dy)
    }
}

// Не враховуючи що ми сортуємо координати складність алгоритму буде О(n) із врахуванням сортування О(n+m)
func calculateClosestGasStations(routePoints: [Point], gasStations: [Point], radius: Double) -> [Point] {
    
    // Сортуємо списки за координатами x
    let sortedRoutePoints = routePoints.sorted { $0.x < $1.x }
    let sortedGasStations = gasStations.sorted { $0.x < $1.x }

    // Створюємо порожній список для зберігання результатів
    var closestStations = [Point]()
    
    // Створюємо ітератори для маршрутних точок та заправок
    var route_iter = sortedRoutePoints.makeIterator()
    var station_iter = sortedGasStations.makeIterator()

    // Ініціалізуємо поточні у кожному списку
    var currentRoutePoint = route_iter.next()
    var currentStation = station_iter.next()

    // Ітеруємо одночасно через обидва списки
    while let currentPoint = currentRoutePoint, let currentGas = currentStation {
        // Якщо координата x станції менша або рівна координаті x маршрутної точки
        if currentGas.x <= currentPoint.x + radius {
            // Перевіряємо відстань між точками та додаємо до результату, якщо відстань <= радіусу
            if currentGas.distance(to: currentPoint) <= radius {
                closestStations.append(currentGas)
            }
            // Змінюємо ітератор station_iter на наступну станцію
            currentStation = station_iter.next()
        } else {
            // Змінюємо ітератор route_iter на наступну маршрутну точку
            currentRoutePoint = route_iter.next()
        }
    }

    return closestStations
}

// Задаємо точки заправок та маршруту
let gasStations = [
    Point(x: 1, y: 1),
    Point(x: 5, y: 5),
    Point(x: 10, y: 10),
    Point(x: 20, y: 20),
    Point(x: 30, y: 30),
]

let routePoints = [
    Point(x: 0, y: 0),
    Point(x: 2, y: 2),
    Point(x: 4, y: 4),
    Point(x: 6, y: 6),
    Point(x: 8, y: 8),
]


let radius = 2.0

let closestStations = calculateClosestGasStations(routePoints: routePoints, gasStations: gasStations, radius: radius)

print("Заправки, що знаходяться в радіусі \(radius) одиниць від маршруту:")
for station in closestStations {
    print("(\(station.x), \(station.y))")
}
