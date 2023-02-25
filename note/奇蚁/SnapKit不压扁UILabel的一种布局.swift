nameStateLabel.setContentHuggingPriority(.required, for: .horizontal)
nameStateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
nameStateLabel.snp.makeConstraints { make in
    make.left.equalTo(nameLabel.snp.right).offset(5)
    make.centerY.equalTo(nameLabel.snp.centerY)
    make.right.lessThanOrEqualTo(stateLabel.snp.left).offset(-5)
}