//
//  PlayerUI.swift
//  AmpCore
//
//  Created by David Cortes on 2/21/20.
//  Copyright © 2020 Akamai. All rights reserved.
//

import UIKit

@IBDesignable open class PlayerUI: PlayerUIView {
    
    //Constraints Constants
    let PIP_HEIGHT = "PIPHEIGHT"
    let PIP_WIDTH = "PIPHEIGHT"
    let AIRPLAY_HEIGHT = "AIRPLAYHEIGHT"
    let AIRPLAY_WIDTH = "AIRPLAYWIDTH"
    let REWIND_WIDTH = "REWINDWIDTH"
    let REWIND_HEIGHT = "REWINDHEIGHT"
    let PLAY_WIDTH = "PLAYWIDTH"
    let PLAY_HEIGHT = "PLAYHEIGHT"
    let FORWARD_WIDTH = "FORWARDWIDTH"
    let FORWARD_HEIGHT = "FORWARDHEIGHT"
    let CURRENTIME_WIDTH = "CURRENTIMEWIDTH"
    let DURATION_WIDTH = "DURATIONWIDTH"
    let FULLSCREEN_WIDTH = "FULLSCREENWIDTH"
    let FULLSCREEN_HEIGHT = "FULLSCREENHEIGHT"
    let SETTINGS_WIDTH = "SETTINGSWIDTH"
    let SETTINGS_HEIGHT = "SETTINGSHEIGHT"
    let MUTE_WIDTH = "MUTEWIDTH"
    let MUTE_HEIGHT = "MUTEHEIGHT"
    
    let DURATION_TRAILING = "DURATION_TRAILING"
    let BOTTOM_STACKVIEW_TRAILING = "BOTTOM_STACKVIEW_TRAILING"
    let TITLE_LEADING = "TITLE_LEADING"
    let SUBTITLE_LEADING = "SUBTITLE_LEADING"
    let CURRENT_TIME_LEADING = "CURRENT_TIME_TRAILING"
    let TIME_SLIDER_LEADING = "TIME_SLIDER_LEADING"
    let TIME_SLIDER_LEADING_EDGE = "TIME_SLIDER_LEADING_EDGE"
    let TIME_SLIDER_TRAILING = "TIME_SLIDER_TRAILING"
    let TIME_SLIDER_BOTTOM = "TIME_SLIDER_BOTTOM"
    
    //Airplay Button properties
    @IBInspectable open var airplayIsHidden: Bool = false {
        didSet {
            airplayButton?.isHidden = airplayIsHidden
        }
    }
    
    //Rewind Button properties
    var rewindImageValue:UIImage?
    @IBInspectable open var rewindImage:UIImage? {
        set {
            rewindImageValue = newValue
            rewindButton?.image = newValue
        }
        
        get {
            return rewindImageValue ?? UIImage(named: "rr", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var rewindIsHidden: Bool = false {
        didSet {
            rewindButton?.isHidden = rewindIsHidden
        }
    }
    
    //Forward Button properties
    var forwardImageValue:UIImage?
    @IBInspectable open var forwardImage:UIImage? {
        set {
            forwardImageValue = newValue
            forwardButton?.image = newValue
        }
        
        get {
            return forwardImageValue ?? UIImage(named: "ff", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var forwardIsHidden: Bool = false {
        didSet {
            forwardButton?.isHidden = forwardIsHidden
        }
    }
    
    //Play/Pause button properties
    var playImageValue:UIImage?
    @IBInspectable open var playImage:UIImage? {
        set {
            playImageValue = newValue
            playPauseButton?.playImage = newValue
        }
        
        get {
            return playImageValue ?? UIImage(named: "play", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var pauseImageValue:UIImage?
    @IBInspectable open var pauseImage:UIImage? {
        
        set {
            pauseImageValue = newValue
            playPauseButton?.pauseImage = newValue
        }

        get {
           return pauseImageValue ??  UIImage(named: "pause", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
        
    }
    
    @IBInspectable open var playIsHidden: Bool = false {
        didSet {
            playPauseButton?.isHidden = playIsHidden
        }
    }
    
    //Picture in Picture button properties
    var pipImageValue: UIImage?
    @IBInspectable open var pipImage:UIImage? {
        
        set {
            pipImageValue = newValue
            pipButton?.pipImage = newValue
        }

        get {
           return pipImageValue ??  UIImage(named: "pip", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var pipIsHidden: Bool = false {
        didSet {
            pipButton?.isHidden = pipIsHidden
        }
    }
    
    // Mute Button properties
    var muteImageValue:UIImage?
    @IBInspectable open var muteImage:UIImage? {
        
        set {
            muteImageValue = newValue
            muteButton?.muteImage = newValue
        }

        get {
           return muteImageValue ??  UIImage(named: "mute", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var unmuteImageValue:UIImage?
    @IBInspectable open var unMuteImage:UIImage? {
        
        set {
            unmuteImageValue = newValue
            muteButton?.unmuteImage = newValue
        }

        get {
           return unmuteImageValue ??  UIImage(named: "unmute", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var muteIsHidden: Bool = false {
        didSet {
            muteButton?.isHidden = muteIsHidden
            if muteIsHidden && settingsIsHidden && fullscreenIsHidden {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = 0
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = 0
                }
            }else {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = -10
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = -5
                }
            }
        }
    }
    
    // Settings Button properties
    var settingsImageValue:UIImage?
    @IBInspectable open var settingsImage:UIImage? {
        
        set {
            settingsImageValue = newValue
            settingsButton?.image = newValue
        }

        get {
           return settingsImageValue ??  UIImage(named: "settings", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var settingsIsHidden: Bool = false {
        didSet {
            settingsButton?.isHidden = settingsIsHidden
            if muteIsHidden && settingsIsHidden && fullscreenIsHidden {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = 0
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = 0
                }
            }else {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = -10
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = -5
                }
            }
        }
    }
    
    // Fullscreen button properties
    var fullscreenImageValue:UIImage?
    @IBInspectable open var fullscreenImage:UIImage? {
        set {
            fullscreenImageValue = newValue
            fullScreenButton?.expandImage = newValue
        }

        get {
            return fullscreenImageValue ??  UIImage(named: "enterfullscreen", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var collapseImageValue:UIImage?
    @IBInspectable open var collapseImage:UIImage? {
        
        set {
            collapseImageValue = newValue
            fullScreenButton?.collapseImage = newValue
        }

        get {
            return collapseImageValue ??  UIImage(named: "exitfullscreen", in: Bundle(for: AmpPlayer.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable open var fullscreenIsHidden: Bool = false {
        didSet {
            fullScreenButton?.isHidden = fullscreenIsHidden
            if muteIsHidden && settingsIsHidden && fullscreenIsHidden {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = 0
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = 0
                }
            }else {
                bottomStackView.superview?.recursiveConstraints(withIdentifier: BOTTOM_STACKVIEW_TRAILING).forEach {
                    $0.constant = -10
                }
                durationLabel?.superview?.recursiveConstraints(withIdentifier: DURATION_TRAILING).forEach {
                    $0.constant = -5
                }
            }
        }
    }
    
    // Title and subtitle properties
    @IBInspectable open var titleText: String = "" {
        didSet {
            titleLabel?.text = titleText
        }
    }
    
    @IBInspectable open var subTitleText: String = "" {
        didSet {
            subtitleLabel?.text = subTitleText
        }
    }
    
    @IBInspectable open var isTitleHidden: Bool = false {
        didSet {
            titleLabel?.isHidden = isTitleHidden
        }
    }
    
    @IBInspectable open var isSubtitleHidden: Bool = false {
        didSet {
            subtitleLabel?.isHidden = isSubtitleHidden
        }
    }
    
    // Scrub Properties
    @IBInspectable open var bufferColor: UIColor = UIColor.clear {
        didSet {
            timeSlider?.bufferColor = bufferColor
        }
    }
    
    @IBInspectable open var maximumTrackTintColor: UIColor = UIColor.lightGray {
        didSet {
            timeSlider?.sliderColor = maximumTrackTintColor
        }
    }
    
    @IBInspectable open var progressTintColor: UIColor = UIColor.white {
        didSet {
            timeSlider?.progressColor = progressTintColor
        }
    }
    
    @IBInspectable open var progressBarInset: CGFloat = 8 {
        didSet {
            progressConstraint?.constant = -1 * progressBarInset
        }
    }
    
    var progressConstraint:NSLayoutConstraint?
    
    var airplayButton:AmpAirplay2Button?
    var titleLabel:UILabel?
    var subtitleLabel:UILabel?
    var pipButton:AmpPiPButton?
    
    var rewindButton:AmpRewindButton?
    var playPauseButton:AmpPlayBackButton?
    var forwardButton:AmpForwardButton?
    
    var currentTimeLabel:AmpCurrentTimeLabel?
    var timeSlider:AmpCustomSlider?
    var durationLabel:AmpDurationLabel?
    
    var muteButton:AmpMuteButton?
    var settingsButton:AmpSettingsButton?
    var fullScreenButton:AmpFullScreenButton?
    let bottomStackView = UIStackView()
    
    override public var player: AmpPlayer? {
        didSet{
            self.playPauseButton?.player = player
            self.airplayButton?.player = player
            self.pipButton?.player = player
            self.rewindButton?.player = player
            self.forwardButton?.player = player
            self.currentTimeLabel?.player = player
            self.timeSlider?.player = player
            self.durationLabel?.player = player
            self.muteButton?.player = player
            self.settingsButton?.player = player
            self.fullScreenButton?.player = player
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initComponents(player: self.player)
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initComponents(player: self.player)
        setupConstraints()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        rewindButton?.setImage(rewindImage, for: .normal)
        forwardButton?.setImage(forwardImage, for: .normal)
        playPauseButton?.setImage(playImage, for: .normal)
        pipButton?.setImage(pipImage, for: .normal)
        muteButton?.setImage(muteImage, for: .normal)
        settingsButton?.setImage(settingsImage, for: .normal)
        fullScreenButton?.setImage(fullscreenImage, for: .normal)
        titleLabel?.text = titleText
        subtitleLabel?.text = subTitleText
        timeSlider?.bufferColor = bufferColor
        timeSlider?.sliderColor = maximumTrackTintColor
        timeSlider?.progressColor = progressTintColor
    }
    
    fileprivate func initComponents(player:AmpPlayer?) {
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.defaultFont(with: 18.0)
        titleLabel?.textColor = UIColor.white
        
        subtitleLabel = UILabel(frame: CGRect.zero)
        subtitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel?.font = UIFont.defaultFont(with: 15.0)
        subtitleLabel?.textColor = UIColor.white
        
        airplayButton = AmpAirplay2Button(frame: CGRect.zero, player: player)
        pipButton = AmpPiPButton(frame: CGRect.zero, player: player)
        
        rewindButton = AmpRewindButton(frame: CGRect.zero, player: player)
        playPauseButton = AmpPlayBackButton(frame: CGRect.zero, player: player )
        forwardButton = AmpForwardButton(frame: CGRect.zero, player: player)
        
        currentTimeLabel = AmpCurrentTimeLabel(frame: CGRect.zero, player: player)
        currentTimeLabel?.font = UIFont.defaultFont(with: 15.0)

        timeSlider = AmpCustomSlider(frame: CGRect.zero, player: player)
        timeSlider?.translatesAutoresizingMaskIntoConstraints = false
        timeSlider?.container = self
        
        durationLabel = AmpDurationLabel(frame: CGRect.zero, player: player, prefix: " / ", livePrefix: " ")
        durationLabel?.font = UIFont.defaultFont(with: 15.0)
        
        muteButton = AmpMuteButton(frame: CGRect.zero, player: player)
        settingsButton = AmpSettingsButton(frame: CGRect.zero, player: player)
        fullScreenButton = AmpFullScreenButton(frame: CGRect.zero, player: player)
        
    }
    
    fileprivate func setupConstraints() {
        
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        topStackView.alignment = .fill
        topStackView.spacing = 10
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        pipButton!.heightAnchor.constraint(equalToConstant: 28, identifier: PIP_HEIGHT).isActive = true
        pipButton!.widthAnchor.constraint(equalToConstant: 28, identifier: PIP_WIDTH).isActive = true
        airplayButton!.heightAnchor.constraint(equalToConstant: 28).isActive = true
        airplayButton!.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        topStackView.addArrangedSubview(pipButton!)
        topStackView.addArrangedSubview(airplayButton!)
        
        self.addSubview(topStackView)
        self.addSubview(titleLabel!)
        self.addSubview(subtitleLabel!)
        
        titleLabel?.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10, identifier: TITLE_LEADING).isActive = true
        subtitleLabel?.topAnchor.constraint(equalTo: titleLabel!.bottomAnchor, constant: 2).isActive = true
        subtitleLabel?.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10, identifier: SUBTITLE_LEADING).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 30
        
        rewindButton?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        rewindButton?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        playPauseButton?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        playPauseButton?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        
        forwardButton?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        forwardButton?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        stackView.addArrangedSubview(rewindButton!)
        stackView.addArrangedSubview(playPauseButton!)
        stackView.addArrangedSubview(forwardButton!)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(currentTimeLabel!)
        self.addSubview(timeSlider!)
        self.addSubview(durationLabel!)
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.alignment = .fill
        bottomStackView.spacing = 15
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomStackView.addArrangedSubview(muteButton!)
        bottomStackView.addArrangedSubview(settingsButton!)
        bottomStackView.addArrangedSubview(fullScreenButton!)
        
        self.addSubview(bottomStackView)
        
        let guide = self.safeAreaLayoutGuide
        titleLabel?.topAnchor.constraint(equalTo: guide.topAnchor, constant: 3).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
        topStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 3).isActive = true
        self.currentTimeLabel?.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10, identifier: CURRENT_TIME_LEADING).isActive = true
        
        currentTimeLabel?.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        
        durationLabel?.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        bottomStackView.bottomAnchor.constraint(equalTo: timeSlider?.topAnchor ?? guide.bottomAnchor, constant: timeSlider != nil ? 0 : -5).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10, identifier: BOTTOM_STACKVIEW_TRAILING).isActive = true

        progressConstraint = timeSlider?.centerYAnchor.constraint(equalTo: guide.bottomAnchor, constant: -1 * progressBarInset)
        progressConstraint?.isActive = true
        
        timeSlider?.heightAnchor.constraint(equalToConstant: 16).isActive = true
        timeSlider?.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        timeSlider?.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
        
        
        
        self.durationLabel?.leadingAnchor.constraint(equalTo: currentTimeLabel?.trailingAnchor, constant: 0, identifier: DURATION_TRAILING).isActive = true
        
        self.fullScreenButton?.widthAnchor.constraint(equalToConstant: 22, identifier: FULLSCREEN_WIDTH).isActive = true
        self.fullScreenButton?.heightAnchor.constraint(equalToConstant: 22, identifier: FULLSCREEN_HEIGHT).isActive = true
        
        self.settingsButton?.widthAnchor.constraint(equalToConstant: 22, identifier: SETTINGS_WIDTH).isActive = true
        self.settingsButton?.heightAnchor.constraint(equalToConstant: 22, identifier: SETTINGS_HEIGHT).isActive = true
        
        self.muteButton?.widthAnchor.constraint(equalToConstant: 22, identifier: MUTE_WIDTH).isActive = true
        self.muteButton?.heightAnchor.constraint(equalToConstant: 22, identifier: MUTE_HEIGHT).isActive = true
    }
    
    override func checkMovingViewCollitions(from view: AmpUIComponent, rect: CGRect?) {
        let collidingViews = [currentTimeLabel, durationLabel, bottomStackView]
        if timeSlider === view {
            if rect == nil {
                collidingViews.forEach{ $0?.isHidden = false }
            } else if let internalRect = timeSlider?.convert(rect!, to: self) {
                collidingViews.forEach {
                    if let fr = $0?.frame {
                        $0?.isHidden = internalRect.intersects(fr)
                    }
                }
            }
        }
    }
    
    
}
