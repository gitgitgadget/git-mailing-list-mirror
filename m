From: Shawn Pearce <spearce@spearce.org>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 11:51:46 -0500
Message-ID: <20060302165146.GA18929@spearce.org>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com> <20060302152329.GH2781@trixie.casa.cgf.cx> <81b0412b0603020735j603b3518ob5e27a02c531093a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Faylor <me@cgf.cx>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 17:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEr23-0006RT-Jk
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCBQv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWCBQv7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:51:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:10445 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751349AbWCBQv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 11:51:59 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEr1k-0001Ta-1m; Thu, 02 Mar 2006 11:51:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DF6FF20FBBF; Thu,  2 Mar 2006 11:51:46 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0603020735j603b3518ob5e27a02c531093a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17093>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/2/06, Christopher Faylor <me@cgf.cx> wrote:
> >
> > Are we *really* contemplating porting git to native Windows?
> >
> 
> Actually, I wasn't thinking about that when I was writing that mail,
> but ... why not?
> Cygwin makes syscalls many times slower, git is very slow on
> windows, users (well, I) want it faster, so if the needed api subset
> can be narrowed down to a reasonable amount of work - I think
> I'd give the idea a try.

I'd certainly appreciate faster response times from GIT on Windows.
Hell, I'd port GIT myself and cross my fingers that Junio, et. al.
would be open to accepting the changes into the tree.

But right now I don't really have a Windows development environment
available to me that I can hack on releasable changes from (damn
lawyers and those agreements about things on work computers being
owned by work).  If I get time I'll try rebuilding a system at
home that is currently offline due to failed disk as a Windows
development environment.

-- 
Shawn.
