From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 22:05:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112202180.31053@racer.site>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <alpine.LSU.1.00.0801112127040.31053@racer.site> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDS0c-0003X1-UI
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761793AbYAKWFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761756AbYAKWFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:05:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:53937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761075AbYAKWFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:05:24 -0500
Received: (qmail invoked by alias); 11 Jan 2008 22:05:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 11 Jan 2008 23:05:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rlaE6nvyr4W6sn6Lnk87ac65q2jxKISztT7j5+l
	dzHjvobTxO3NmW
X-X-Sender: gene099@racer.site
In-Reply-To: <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70212>

Hi,

On Fri, 11 Jan 2008, Kevin Ballard wrote:

> On Jan 11, 2008, at 4:29 PM, Johannes Schindelin wrote:
> 
> > If you are serious about this problem, I can give you tons of pointers 
> > how to go solve it.  (Although I might be disconnected this weekend, 
> > because of the lack of competence of the IT department here.)
> 
> I think I've got a handle on it. I've already expunged the mis-cased 
> file using git-rebase to remove the offending commit, now I just need to 
> rewrite the second commit's message so it looks like the original commit 
> (luckily I didn't do any work in the directory before I re-cased it). 
> Thanks anyway.

I was not talking about fixing it up in your repository.  If you really 
think that git should help you, you gotta teach it to.  Because people who 
do not experience the same as you will be less likely to feel the urge to 
teach git to help in that situation (because they did not experience that 
situation yet).  For example, I am one of these people.  And I guess a lot 
of these people hang out on this list.

Ciao,
Dscho
