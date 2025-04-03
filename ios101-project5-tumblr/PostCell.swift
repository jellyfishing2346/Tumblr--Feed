//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Faizan Khan on 4/3/25.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - UI Components
    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(postImageView)
        contentView.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            summaryLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        summaryLabel.text = nil
    }
}
