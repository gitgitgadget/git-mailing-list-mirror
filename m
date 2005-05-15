From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Sun, 15 May 2005 21:48:03 +0200
Message-ID: <20050515194803.GI13024@pasky.ji.cz>
References: <Pine.LNX.4.44.0505151204230.2136-100000@bellevue.puremagic.com> <7vfywothpp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad Roberts <braddr@puremagic.com>,
	Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:48:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXP5h-0005Cl-Dw
	for gcvg-git@gmane.org; Sun, 15 May 2005 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEOTsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 15:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEOTsJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 15:48:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65207 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261207AbVEOTsF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 15:48:05 -0400
Received: (qmail 19180 invoked by uid 2001); 15 May 2005 19:48:03 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfywothpp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 09:25:06PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "BR" == Brad Roberts <braddr@puremagic.com> writes:
> 
> >> I've merged some of the minor stuff for now.
> 
> BR> Cool, though there appears to have been some objections. :)
> 
> I do not have any problem with what the _patch_ does at all.  I
> had more trouble in the process of how the patch appeared in
> git-pb tree, and I still do.
> 
> Please consider the revert request retracted.  Request to
> forewarn people in the mailing list still stands.

Well, it isn't like this was some huge large-scale change; the diff is
quite small. Do you want me to announce _any_ identifier renames in
advance on the mailing list? Or where should be the threshold? These
were three renames of not-so-frequently used identifiers.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
