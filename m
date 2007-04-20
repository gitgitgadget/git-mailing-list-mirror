From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 15:57:12 +0200
Message-ID: <20070420135712.GN4489@pasky.or.cz>
References: <200704181426.29969.andyparkins@gmail.com> <462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com> <7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net> <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net> <4627B292.6080202@midwinter.com> <7vd52054e3.fsf@assigned-by-dhcp.cox.net> <20070420101801.GA13560@diana.vm.bytemark.co.uk> <7vr6qf1g9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Steven Grimm <koreth@midwinter.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hetby-00056G-CZ
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbXDTN5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbXDTN5P
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:57:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47315 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbXDTN5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:57:14 -0400
Received: (qmail 30258 invoked by uid 2001); 20 Apr 2007 15:57:12 +0200
Content-Disposition: inline
In-Reply-To: <7vr6qf1g9c.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45104>

On Fri, Apr 20, 2007 at 12:39:43PM CEST, Junio C Hamano wrote:
> The problem I described is that sometimes I
> do not even recall if I was rebasing or merging after resolving
> conflicts.  If I *knew* I was in the middle of a rebase, I know
> where to look (.dotest/ has all the necessary "state" for
> rebase/am to continue) to remind me where I was.

In Cogito, cg-status always tell you that you're in the middle of
something special if you are. Perhaps git status could let you know as
well. (It wouldn't be as easy to see since git status seems so verbose
though compared to cg-status; that has been one of my pet peeves, though
I suppose it's unlikely to change. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
