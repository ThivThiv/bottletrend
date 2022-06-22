class Batch < ApplicationRecord
  has_many :bottles, dependent: :destroy
  belongs_to :domain
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description, :year, :region ],
    associated_against: {
      domain: [ :name, :description]
    },
    using: {
      tsearch: { prefix: true }
    }

  def current_price
    if available_domain_stock.positive?
      self.initial_price
    else
      last_transactions = Bottle.joins(:transactions).where(batch: self).map(&:last_transaction)
      last_transaction = last_transactions.sort_by{|t| t.created_at }.last
      Transaction.compute_price(last_transaction.price, self)
    end
  end

  def available_domain_stock
    self.quantity - self.bottles.count
  end

  def available_users_stock
    self.bottles.map(&:last_transaction).select do |t|
      if t
        t.on_resale == true
      end
    end.count
  end

  def available?
    (available_domain_stock + available_users_stock) > 0
  end

  def quality
    tableau = {
      "2003": {"Alsace": 3, "Beaujolais": 4, "Bordeaux": 4, "Bourgogne": 4, "Champagne": 2, "Jura": 4, "Languedoc-Roussillon": 3, "Provence": 4, "Savoie": 4, "Sud-Ouest": 4, "Val de Loire": 5, "Vallée du Rhône": 4 },
      "2004": {"Alsace": 2, "Beaujolais": 2, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 4, "Jura": 2, "Languedoc-Roussillon": 2, "Provence": 3, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 3, "Vallée du Rhône": 3 },
      "2005": {"Alsace": 4, "Beaujolais": 5, "Bordeaux": 5, "Bourgogne": 5, "Champagne": 2, "Jura": 5, "Languedoc-Roussillon": 3, "Provence": 4, "Savoie": 4, "Sud-Ouest": 5, "Val de Loire": 5, "Vallée du Rhône": 4 },
      "2006": {"Alsace": 2, "Beaujolais": 3, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 3, "Jura": 3, "Languedoc-Roussillon": 2, "Provence": 3, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 3, "Vallée du Rhône": 4 },
      "2007": {"Alsace": 4, "Beaujolais": 3, "Bordeaux": 3, "Bourgogne": 4, "Champagne": 3, "Jura": 3, "Languedoc-Roussillon": 5, "Provence": 3, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 3, "Vallée du Rhône": 3 },
      "2008": {"Alsace": 3, "Beaujolais": 3, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 4, "Jura": 3, "Languedoc-Roussillon": 3, "Provence": 3, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 3, "Vallée du Rhône": 2 },
      "2009": {"Alsace": 3, "Beaujolais": 5, "Bordeaux": 5, "Bourgogne": 5, "Champagne": 5, "Jura": 5, "Languedoc-Roussillon": 3, "Provence": 4, "Savoie": 4, "Sud-Ouest": 5, "Val de Loire": 5, "Vallée du Rhône": 5 },
      "2010": {"Alsace": 4, "Beaujolais": 4, "Bordeaux": 5, "Bourgogne": 4, "Champagne": 3, "Jura": 3, "Languedoc-Roussillon": 3, "Provence": 5, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 3, "Vallée du Rhône": 4 },
      "2011": {"Alsace": 3, "Beaujolais": 5, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 4, "Jura": 3, "Languedoc-Roussillon": 4, "Provence": 3, "Savoie": 3, "Sud-Ouest": 4, "Val de Loire": 2, "Vallée du Rhône": 3 },
      "2012": {"Alsace": 3, "Beaujolais": 3, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 4, "Jura": 2, "Languedoc-Roussillon": 2, "Provence": 3, "Savoie": 3, "Sud-Ouest": 2, "Val de Loire": 2, "Vallée du Rhône": 4 },
      "2013": {"Alsace": 2, "Beaujolais": 2, "Bordeaux": 1, "Bourgogne": 2, "Champagne": 3, "Jura": 1, "Languedoc-Roussillon": 2, "Provence": 2, "Savoie": 3, "Sud-Ouest": 1, "Val de Loire": 1, "Vallée du Rhône": 2 },
      "2014": {"Alsace": 4, "Beaujolais": 4, "Bordeaux": 3, "Bourgogne": 4, "Champagne": 3, "Jura": 2, "Languedoc-Roussillon": 4, "Provence": 4, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 4, "Vallée du Rhône": 4 },
      "2015": {"Alsace": 2, "Beaujolais": 5, "Bordeaux": 4, "Bourgogne": 5, "Champagne": 5, "Jura": 4, "Languedoc-Roussillon": 4, "Provence": 3, "Savoie": 3, "Sud-Ouest": 4, "Val de Loire": 4, "Vallée du Rhône": 5 },
      "2016": {"Alsace": 3, "Beaujolais": 4, "Bordeaux": 5, "Bourgogne": 3, "Champagne": 3, "Jura": 4, "Languedoc-Roussillon": 4, "Provence": 4, "Savoie": 3, "Sud-Ouest": 4, "Val de Loire": 4, "Vallée du Rhône": 4 },
      "2017": {"Alsace": 3, "Beaujolais": 4, "Bordeaux": 3, "Bourgogne": 3, "Champagne": 2, "Jura": 3, "Languedoc-Roussillon": 4, "Provence": 4, "Savoie": 3, "Sud-Ouest": 3, "Val de Loire": 4, "Vallée du Rhône": 4 },
      "2018": {"Alsace": 4, "Beaujolais": 5, "Bordeaux": 5, "Bourgogne": 4, "Champagne": 4, "Jura": 4, "Languedoc-Roussillon": 4, "Provence": 3, "Savoie": 3, "Sud-Ouest": 4, "Val de Loire": 3, "Vallée du Rhône": 4 },
      "2019": {"Alsace": 5, "Beaujolais": 4, "Bordeaux": 5, "Bourgogne": 4, "Champagne": 4, "Jura": 4, "Languedoc-Roussillon": 3, "Provence": 3, "Savoie": 4, "Sud-Ouest": 4, "Val de Loire": 4, "Vallée du Rhône": 3 },
      "2020": {"Alsace": 4, "Beaujolais": 4, "Bordeaux": 5, "Bourgogne": 4, "Champagne": 3, "Jura": 4, "Languedoc-Roussillon": 4, "Provence": 4, "Savoie": 5, "Sud-Ouest": 5, "Val de Loire": 4, "Vallée du Rhône": 4 }
    }
    return tableau[:"#{self.year}"][:"#{self.region}"]
  end

  def pourcent_trend
    if current_price.to_f / initial_price.to_f == 1
      "-"
    else
      (current_price / initial_price.to_f).truncate(1)
    end
  end

  def price_trend
    @price_difference = (self.current_price - self.initial_price.to_f).truncate(2)
  end

end
