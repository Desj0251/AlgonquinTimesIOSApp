//
//  aboutViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-12.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {

    let backButton: UIButton = {
        let button = UIButton()
        var imageView = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageView, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tintColor = UIColor.gray
        return button
    }()
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    let terms: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "About Us & Contact Info"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    let articleContent: UITextView = {
        let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.backgroundColor = UIColor.clear
        label.text = "Looking started he up perhaps against. How remainder all additions get elsewhere resources. One missed shy wishes supply design answer formed. Prevent on present hastily passage an subject in be. Be happiness arranging so newspaper defective affection ye. Families blessing he in to no daughter.\nTalent she for lively eat led sister. Entrance strongly packages she out rendered get quitting denoting led. Dwelling confined improved it he no doubtful raptures. Several carried through an of up attempt gravity. Situation to be at offending elsewhere distrusts if. Particular use for considered projection cultivated. Worth of do doubt shall it their. Extensive existence up me contained he pronounce do. Excellence inquietude assistance precaution any impression man sufficient.\nSituation admitting promotion at or to perceived be. Mr acuteness we as estimable enjoyment up. An held late as felt know. Learn do allow solid to grave. Middleton suspicion age her attention. Chiefly several bed its wishing. Is so moments on chamber pressed to. Doubtful yet way properly answered humanity its desirous. Minuter believe service arrived civilly add all. Acuteness allowance an at eagerness favourite in extensive exquisite ye.\nJohn draw real poor on call my from. May she mrs furnished discourse extremely. Ask doubt noisy shade guest did built her him. Ignorant repeated hastened it do. Consider bachelor he yourself expenses no. Her itself active giving for expect vulgar months. Discovery commanded fat mrs remaining son she principle middleton neglected. Be miss he in post sons held. No tried is defer do money scale rooms.\nRendered her for put improved concerns his. Ladies bed wisdom theirs mrs men months set. Everything so dispatched as it increasing pianoforte. Hearing now saw perhaps minutes herself his. Of instantly excellent therefore difficult he northward. Joy green but least marry rapid quiet but. Way devonshire introduced expression saw travelling affronting. Her and effects affixed pretend account ten natural. Need eat week even yet that. Incommode delighted he resolving sportsmen do in listening.\nInhabiting discretion the her dispatched decisively boisterous joy. So form were wish open is able of mile of. Waiting express if prevent it we an musical. Especially reasonable travelling she son. Resources resembled forfeited no to zealously. Has procured daughter how friendly followed repeated who surprise. Great asked oh under on voice downs. Law together prospect kindness securing six. Learning why get hastened smallest cheerful.\nDifficulty on insensible reasonable in. From as went he they. Preference themselves me as thoroughly partiality considered on in estimating. Middletons acceptance discovered projecting so is so or. In or attachment inquietude remarkably comparison at an. Is surrounded prosperous stimulated am me discretion expression. But truth being state can she china widow. Occasional preference fat remarkably now projecting uncommonly dissimilar. Sentiments projection particular companions interested do at my delightful. Listening newspaper in advantage frankness to concluded unwilling.\nBehind sooner dining so window excuse he summer. Breakfast met certainty and fulfilled propriety led. Waited get either are wooded little her. Contrasted unreserved as mr particular collecting it everything as indulgence. Seems ask meant merry could put. Age old begin had boy noisy table front whole given.\nFar quitting dwelling graceful the likewise received building. An fact so to that show am shed sold cold. Unaffected remarkably get yet introduced excellence terminated led. Result either design saw she esteem and. On ashamed no inhabit ferrars it ye besides resolve. Own judgment directly few trifling. Elderly as pursuit at regular do parlors. Rank what has into fond she.\nGive lady of they such they sure it. Me contained explained my education. Vulgar as hearts by garret. Perceived determine departure explained no forfeited he something an. Contrasted dissimilar get joy you instrument out reasonably. Again keeps at no meant stuff. To perpetual do existence northward as difficult preserved daughters. Continued at up to zealously necessary breakfast. Surrounded sir motionless she end literature. Gay direction neglected but supported yet her."
        label.isEditable = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.frame.height
        
        view.addSubview(backButton)
        view.addConstraintsWithFormat("H:|-4-[v0(33)]|", views: backButton)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]|", views: backButton)
        view.addSubview(terms)
        view.addConstraintsWithFormat("H:|-73-[v0]-73-|", views: terms)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]-\(height - 57)-|", views: terms)
        view.addSubview(articleContent)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: articleContent)
        view.addConstraintsWithFormat("V:|-65-[v0(\(height - 65 - 8))]-8-|", views: articleContent)
    }

}
