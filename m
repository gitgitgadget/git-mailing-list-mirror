From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 15:06:30 -0500
Message-ID: <20060131200630.GB16561@fieldses.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org> <20060131181248.GE11955@fieldses.org> <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:07:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F41m3-0006uS-Aw
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWAaUGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWAaUGo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:06:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36274 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751420AbWAaUGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 15:06:43 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F41lm-0004yJ-UJ; Tue, 31 Jan 2006 15:06:30 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15340>

On Tue, Jan 31, 2006 at 11:33:21AM -0800, Junio C Hamano wrote:
> I think many good stuff git offers would not be helpful to the
> users until index is understood as the third entity, in addition
> to the usual "committed state" and "working tree state".  It
> might be better to talk about it sooner rather than later.  And
> the tool is geared towards taking advantage of it, so until the
> user understands that, behaviour of some tools would feel
> unintuitive.

Yeah, makes sense.  But I'd like to introduce that while still
introducing the higher-level tools earlier on than core-tutorial.txt
does.  I'll give some thought to how to move things in that direction,
maybe this weekend....

--b.
