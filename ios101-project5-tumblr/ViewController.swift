//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Properties
    private var tableView: UITableView!
    private var posts: [Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchPosts()
    }
    
    // MARK: - TableView Setup
    private func setupTableView() {
        // Programmatic tableView creation
        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        
        // Configuration
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        
        // Cell registration - using class directly since we're not using storyboard/XIB
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            fatalError("Failed to dequeue PostCell - check your cell implementation")
        }
        
        let post = posts[indexPath.row]
        configureCell(cell, with: post)
        return cell
    }
    
    private func configureCell(_ cell: PostCell, with post: Post) {
        cell.summaryLabel.text = post.summary
        
        if let photo = post.photos.first {
            Nuke.loadImage(with: photo.originalSize.url, into: cell.postImageView)
        }
    }
    
    // MARK: - Networking
    private func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("❌ Network error: \(error)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)
                DispatchQueue.main.async {
                    self?.posts = blog.response.posts
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Decoding error: \(error)")
            }
        }.resume()
    }
}
