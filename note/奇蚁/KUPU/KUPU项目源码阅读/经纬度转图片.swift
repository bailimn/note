MineAPI.getStaticMapUrl(lat: lat, lng: lng).request(type: String?.self).subscribe {[weak self] res in
    self?.mapImageURL.accept(res.body)
} onError: { err in
    err.show()
}.disposed(by: rx.disposeBag)