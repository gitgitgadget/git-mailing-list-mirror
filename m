From: Petr Baudis <pasky@suse.cz>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 8 Nov 2005 13:04:26 +0100
Message-ID: <20051108120426.GB1431@pasky.or.cz>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <20051101091533.GB11618@pasky.or.cz> <20051107225652.GW1431@pasky.or.cz> <200511081150.10867.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 13:04:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZSDK-0007H7-Hq
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 13:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVKHMEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 07:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVKHMEa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 07:04:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32155 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965156AbVKHMEa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 07:04:30 -0500
Received: (qmail 30005 invoked by uid 2001); 8 Nov 2005 13:04:26 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511081150.10867.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11330>

Dear diary, on Tue, Nov 08, 2005 at 11:50:10AM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> told me that...
> On Monday 07 November 2005 23:56, Petr Baudis wrote:
> > Dear diary, on Tue, Nov 01, 2005 at 10:15:33AM CET, I got a letter
> > where Petr Baudis <pasky@suse.cz> told me that...
> > > That said, with a big warning, I would be willing to do something like
> > > cg-merge -s and cg-update -s (s as squash)
> > ...
> > FWIW, cg-merge -s and cg-update -s is supported now.
> 
> The -s option of git merge is about choosing a strategy.
> How can I choose the "recursive" strategy with cg-merge?
> Some consistency would be good here.

Good point. You can't now, but you should be able to in the future.
I renamed this from -s to --squash.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
