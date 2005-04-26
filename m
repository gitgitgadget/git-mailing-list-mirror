From: Petr Baudis <pasky@ucw.cz>
Subject: Re: unseeking?
Date: Tue, 26 Apr 2005 22:28:05 +0200
Message-ID: <20050426202805.GL13224@pasky.ji.cz>
References: <20050425161854.GE11094@tumblerings.org> <Pine.LNX.4.21.0504251236400.30848-100000@iabervon.org> <20050425222833.GA21107@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:23:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWa9-00017D-4o
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDZU2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDZU2J
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:28:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63119 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261573AbVDZU2G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:28:06 -0400
Received: (qmail 31969 invoked by uid 2001); 26 Apr 2005 20:28:05 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050425222833.GA21107@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 12:28:33AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> So, I did 'git patch pasky:this', and got the following. Is this an appropriate
> way to submit a patch? BTW, the 'truckload' fix I tried to change back by
> editing the README again, and committing the change; but the git patch command
> still shows the change.

Because it just exports individual patches. Use git diff (cg-diff) if
you want to get the cummulative diff.

Could you please sign off your patch?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
