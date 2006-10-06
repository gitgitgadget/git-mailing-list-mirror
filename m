From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Unresolved issues #4
Date: Fri, 6 Oct 2006 12:11:01 -0400
Message-ID: <20061006161101.GB20024@spearce.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <7vfye20xjt.fsf@assigned-by-dhcp.cox.net> <eg5co6$g9n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 18:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsI2-0003Py-GE
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJFQLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWJFQLG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:11:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59612 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751560AbWJFQLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 12:11:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GVsHo-0001ze-Ag; Fri, 06 Oct 2006 12:10:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A54B20E490; Fri,  6 Oct 2006 12:11:01 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg5co6$g9n$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28413>

Jakub Narebski <jnareb@gmail.com> wrote:
> > From: Shawn Pearce <spearce@spearce.org>
> > Message-ID: <20060930045037.GB18479@spearce.org>
> > 
> > "git ref-log" command to interact with ref-log?
> > 
> > [jc: not much interest from users?]
> 
> I thing it can increase number of reflog users. 

Agreed and I'd really like to see that command but I have not had the
time to do code it myself.  What time I am able to make available
for Git in the near future needs to be for the window mmap rewrite
ontop of Nico's delta offset changes that are currently in next.

If nobody gets around to it I'll likely try to pick it up and do it,
but that probably won't be for at least a month, maybe two.

-- 
Shawn.
