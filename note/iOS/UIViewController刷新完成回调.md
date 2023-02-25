``` swift
UIView.animate(withDuration: 0.0) {
    self.headerView.pagerView.reloadData()
} completion: { finished in
    self.checkFirst()
}
```