From: Christopher Li <git@chrisli.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 16:30:13 -0400
Message-ID: <20050414203013.GD25468@64m.dyndns.org>
References: <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:37:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDtK-0007co-6y
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVDNXkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVDNXkT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:40:19 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16118 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261639AbVDNXkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:40:15 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005041423401401400hb8f0e>; Thu, 14 Apr 2005 23:40:14 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id E5B9F3F1EF; Thu, 14 Apr 2005 16:30:13 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050414233159.GX22699@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2005 at 01:31:59AM +0200, Petr Baudis wrote:
> > I am just trying to follow my understanding of what Linus
> > wanted.  One of the guiding principle is to do as much things as
> > in dircache without ever checking things out or touching working
> > files unnecessarily.
> 
> I'm just arguing that instead of directly touching the directory cache,
> you should just list what would you do there - and you already do this,

That is exactly what I suggest in the previous email. And my python script
does exactly that ;-)

Chris

