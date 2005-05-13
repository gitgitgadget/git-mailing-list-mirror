From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit [its a workspace id, isn't it?]
Date: Sat, 14 May 2005 00:25:03 +0200
Message-ID: <20050513222502.GD32232@pasky.ji.cz>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> <2cfc4032050512183788e01fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 00:30:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWifd-0002Yk-1F
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVEMW3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVEMW1k
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:27:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63112 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262592AbVEMWZE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:25:04 -0400
Received: (qmail 5363 invoked by uid 2001); 13 May 2005 22:25:03 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050512183788e01fc@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 03:37:47AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> > 
> > I would like to suggest a few limiters are set on the repoid.  In
> > particular, I'd like to suggest that a repoid is a UUID, that a file is
> > used to track it (.git/repoid), and that if it doesn't exist, a new one
> > is created from /dev/urandom.
> > 
> 
> I think I understand what Thomas is trying to achieve, but I think
> there is a naming problem here. The marker really isn't a repoid - it
> is a workspace id.

Why not just call the thing "branch"? It's as well eligible for that
term as anything. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
