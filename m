From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Wed, 7 Jun 2006 02:08:16 +0200
Message-ID: <20060607000816.GY10488@pasky.or.cz>
References: <20060604211931.10117.82695.stgit@machine.or.cz> <20060604212050.GV10488@pasky.or.cz> <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org> <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:08:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnlam-0003LA-9Q
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFGAIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFGAIJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:08:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60625 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751385AbWFGAII (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:08:08 -0400
Received: (qmail 2539 invoked by uid 2001); 7 Jun 2006 02:08:16 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21417>

Dear diary, on Wed, Jun 07, 2006 at 02:05:59AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 6 Jun 2006, Junio C Hamano wrote:
> >
> > This allows you to say:
> > 
> > 	git --less diff v2.6.16-rc5..
> 
> I've seriously considered something like that, although you chose a pretty 
> strange - and long - flag.
> 
> I was thinking something like "git -p log -p" (the first "-p" is for 
> "paginate" - think "dir/p" in old DOS times, but we could claim it is for 
> "pager" so that people don't laugh at us)

Actually, you made a case in the misty past that cg-log should just
stuff things through a pager by default and I ended up finding that
extremely convenient - what is the reason git log does not do the same?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
