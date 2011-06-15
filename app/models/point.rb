#encoding: utf-8
class Point < ActiveRecord::Base
  acts_as_list :scope => :area
  belongs_to :area

  validates :latitude, :presence => true
  validates :longitude, :presence => true

  def self.get_distance_to_segment(p1, p2, latitude, longitude)
    d1 = (p1.longitude - p2.longitude)**2 + (p1.latitude - p2.latitude)**2
    d2 = (p1.longitude - longitude)**2 + (p1.latitude - latitude)**2
    d3 = (longitude - p2.longitude)**2 + (latitude - p2.latitude)**2

    # calcul de l'homotétie
    x = p2.longitude + (((p1.longitude - p2.longitude) * (d1 + d3 - d2)) / (2 * d1))
    y = p2.latitude + (((p1.latitude - p2.latitude) * (d1 + d3 - d2)) / (2 * d1))

    # Si on est sur la droite, on prend les coordonnées de l'homotétie
    if (((p1.longitude >= p2.longitude && p1.longitude >= x && p2.longitude <= x) ||
            (p1.longitude <= p2.longitude && p1.longitude <= x && p2.longitude >= x)) &&
          ((p1.latitude >= p2.latitude && p1.latitude >= y && p2.latitude <= y) ||
            (p1.latitude <= p2.latitude && p1.latitude <= y && p2.latitude >= y)))
      distance = Math.sqrt((x - longitude )**2 + (y-latitude)**2)
    else

      # Sinon on prend la distance au point le plus près
      distance = [
        Math.sqrt((p1.longitude - longitude )**2 + (p1.latitude-latitude)**2),
        Math.sqrt((p2.longitude - longitude )**2 + (p2.latitude-latitude)**2),
      ].min
    end
    distance

  end
end