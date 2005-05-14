From: Petr Baudis <pasky@ucw.cz>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 13:14:27 +0200
Message-ID: <20050514111427.GC3905@pasky.ji.cz>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514061914.GB14353@tumblerings.org> <20050514103937.GA3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 14 13:14:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWubU-0001tg-MR
	for gcvg-git@gmane.org; Sat, 14 May 2005 13:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVENLOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 07:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVENLOo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 07:14:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35477 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262737AbVENLO2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 07:14:28 -0400
Received: (qmail 8331 invoked by uid 2001); 14 May 2005 11:14:27 -0000
To: Zack Brown <zbrown@tumblerings.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050514103937.GA3905@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Where was my English? Sorry.

> If it do that, I wonder how much speedup would be using this instead.
(does)
> But probably still significant one.
> 
> What I don't like is that it searches only the author field. I find the
> behaviour that it searches in the committer field as well very useful,
> since I can easily check whose patches on a file I checked it
(which patches of a file I checked in)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
