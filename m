From: Petr Baudis <pasky@ucw.cz>
Subject: Re: unseeking?
Date: Tue, 26 Apr 2005 23:53:28 +0200
Message-ID: <20050426215327.GQ13224@pasky.ji.cz>
References: <20050425161854.GE11094@tumblerings.org> <Pine.LNX.4.21.0504251236400.30848-100000@iabervon.org> <20050425222833.GA21107@tumblerings.org> <20050426202805.GL13224@pasky.ji.cz> <20050426214819.GA14899@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXul-0006U5-5k
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVDZVxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVDZVxd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:53:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37009 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261807AbVDZVx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:53:29 -0400
Received: (qmail 15081 invoked by uid 2001); 26 Apr 2005 21:53:28 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050426214819.GA14899@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 11:48:19PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> On Tue, Apr 26, 2005 at 10:28:05PM +0200, Petr Baudis wrote:
> > Dear diary, on Tue, Apr 26, 2005 at 12:28:33AM CEST, I got a letter
> > where Zack Brown <zbrown@tumblerings.org> told me that...
> > > So, I did 'git patch pasky:this', and got the following. Is this an appropriate
> > > way to submit a patch? BTW, the 'truckload' fix I tried to change back by
> > > editing the README again, and committing the change; but the git patch command
> > > still shows the change.
> > 
> > Because it just exports individual patches. Use git diff (cg-diff) if
> > you want to get the cummulative diff.
> > 
> > Could you please sign off your patch?
> 
> Spelling fixes.
> 
> Signed-off-by: Zack Brown <zbrown@tumblerings.org>

Thanks, applied. (master.kernel.org is now down, so it'll take a while
before I will be able to push it out.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
