//
//  TradingPair.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import Foundation

struct TradingPair: Codable {
    
    let trading_pairs: String
    let base_currency: String
    let quote_currency: String
    let last_price: String
    let lowest_ask: String
    let highest_bid: String
    let base_volume: String
    let quote_volume: String
    let price_change_percent_24h: String
    let highest_price_24h: String
    let lowest_price_24h: String
    
    enum CodingKeys: String, CodingKey {
        
        case trading_pairs
        case base_currency
        case quote_currency
        case last_price
        case lowest_ask
        case highest_bid
        case base_volume
        case quote_volume
        case price_change_percent_24h
        case highest_price_24h
        case lowest_price_24h
    }
    
    enum Titles: String {
        
        case tradingPairs = "Trading pairs: "
        case baseCurrency = "Base currency: "
        case lastPrice = "Last price: "
        case quoteCurrency = "Quote currency: "
        case lowestAsk = "Lower ask: "
        case highestBid = "Highest bid: "
        case baseVolume = "Base volume: "
        case quoteVolume = "Quote volume: "
        case priceChangePercent24h = "Price change per 24h: "
        case highestPrice24h = "Highest price per 24h: "
        case lowestPrice24h = "Lowest price per 24h: "
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let _trading_pairs = try? values.decode(String.self, forKey: .trading_pairs)
        let _base_currency = try? values.decode(String.self, forKey: .base_currency)
        let _quote_currency = try? values.decode(String.self, forKey: .quote_currency)
        let _last_price = try? values.decode(String.self, forKey: .last_price)
        let _lowest_ask = try? values.decode(String.self, forKey: .lowest_ask)
        let _highest_bid = try? values.decode(String.self, forKey: .highest_bid)
        let _base_volume = try? values.decode(String.self, forKey: .base_volume)
        let _quote_volume = try? values.decode(String.self, forKey: .quote_volume)
        let _price_change_percent_24h = try? values.decode(String.self, forKey: .price_change_percent_24h)
        let _highest_price_24h = try? values.decode(String.self, forKey: .highest_price_24h)
        let _lowest_price_24h = try? values.decode(String.self, forKey: .lowest_price_24h)
        
        let _d_trading_pairs = try? values.decode(Double.self, forKey: .trading_pairs).toString()
        let _d_base_currency = try? values.decode(Double.self, forKey: .base_currency).toString()
        let _d_quote_currency = try? values.decode(Double.self, forKey: .quote_currency).toString()
        let _d_last_price = try? values.decode(Double.self, forKey: .last_price).toString()
        let _d_lowest_ask = try? values.decode(Double.self, forKey: .lowest_ask).toString()
        let _d_highest_bid = try? values.decode(Double.self, forKey: .highest_bid).toString()
        let _d_base_volume = try? values.decode(Double.self, forKey: .base_volume).toString()
        let _d_quote_volume = try? values.decode(Double.self, forKey: .quote_volume).toString()
        let _d_price_change_percent_24h = try? values.decode(Double.self, forKey: .price_change_percent_24h).toString()
        let _d_highest_price_24h = try? values.decode(Double.self, forKey: .highest_price_24h).toString()
        let _d_lowest_price_24h = try? values.decode(Double.self, forKey: .lowest_price_24h).toString()
        
        trading_pairs = _trading_pairs ?? _d_trading_pairs ?? ""
        base_currency = _base_currency ?? _d_base_currency ?? ""
        quote_currency = _quote_currency ?? _d_quote_currency ?? ""
        last_price = _last_price ?? _d_last_price ?? ""
        lowest_ask = _lowest_ask ?? _d_lowest_ask ?? ""
        highest_bid = _highest_bid ?? _d_highest_bid ?? ""
        base_volume = _base_volume ?? _d_base_volume ?? ""
        quote_volume = _quote_volume ?? _d_quote_volume ?? ""
        price_change_percent_24h = _price_change_percent_24h ?? _d_price_change_percent_24h ?? ""
        highest_price_24h = _highest_price_24h ?? _d_highest_price_24h ?? ""
        lowest_price_24h = _lowest_price_24h ?? _d_lowest_price_24h ?? ""
        
        
    }
}

extension TradingPair:Identifiable {
    public var id: String { return self.trading_pairs }
}

extension TradingPair {
    var pairName: String {
        let name = self.trading_pairs.split(separator: ".").last?.split(separator: "_")
        return String(name?.first ?? "") + "/" + String(name?.last ?? "")
    }
}
