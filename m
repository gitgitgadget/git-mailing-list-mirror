From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 01:32:59 -0400
Message-ID: <20070420053259.GA29069@spearce.org>
References: <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com> <462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com> <7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net> <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net> <4627B292.6080202@midwinter.com> <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 07:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Helk9-0004Xy-3t
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 07:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbXDTFdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 01:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbXDTFdJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 01:33:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55168 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422808AbXDTFdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 01:33:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Heljy-0008NF-Cm; Fri, 20 Apr 2007 01:33:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF4F020FBAE; Fri, 20 Apr 2007 01:32:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45063>

Junio C Hamano <junkio@cox.net> wrote:
> And I suspect the reason this is confusing to me is not that
> rebase keeps state but that the state is not made more obvious
> to prevent mistakes from happening.  Earlier I mentioned perhaps
> we would want "git, whatnow?" command to remind people what they
> were in the middle of and suggest what the next step would be.
> Or perhaps "git, continue" command that makes the obvious next
> step to happen would be helpful.

You use bash, right?  What about teaching your PS1 how to show
you if you are in the middle of a rebase?  Doesn't it show you
the current branch already?  ;-)

-- 
Shawn.
