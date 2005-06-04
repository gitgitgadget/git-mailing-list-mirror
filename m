From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 4 Jun 2005 21:46:26 +0200
Message-ID: <20050604194626.GA7084@pasky.ji.cz>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org> <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org> <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org> <7vekbigo8q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org> <Pine.LNX.4.58.0506040847170.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 21:43:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeeY6-0001vA-Bl
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 21:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFDTqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFDTqd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 15:46:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65165 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261233AbVFDTqc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 15:46:32 -0400
Received: (qmail 25743 invoked by uid 2001); 4 Jun 2005 19:46:26 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506040847170.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 04, 2005 at 05:51:13PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Would people prefer to have "git-rev-list" take arguments like
> 
> 	git-rev-list a b ^c ^d
> 
> the way git-rev-tree does?

Yes, please. I think that usage is more consistent and more flexible.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
