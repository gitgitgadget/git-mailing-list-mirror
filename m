From: Christopher Li <git@chrisli.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Wed, 13 Apr 2005 21:23:52 -0400
Message-ID: <20050414012352.GA17700@64m.dyndns.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org> <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 06:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLvzq-0002m2-Ts
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 06:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVDNEdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 00:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVDNEdq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 00:33:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54262 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261432AbVDNEdo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 00:33:44 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005041404334301400hdrn5e>; Thu, 14 Apr 2005 04:33:44 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 7F74E3F1EF; Wed, 13 Apr 2005 21:23:52 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2005 at 08:51:50PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 14 Apr 2005, Petr Baudis wrote:
> 
> Thick skin is the name of the game. I'd not get any work done otherwise.
> 
> On that note - I've been avoiding doing the merge-tree thing, in the hope 
> that somebody else does what I've described. I really do suck at scripting 
> things, yet this is clearly something where using C to do a lot of the 
> stuff is pointless.
> 
> Almost all the parts do seem to be there, ie Daniel did the "common 
> parent" part, and the rest really does seem to be more about scripting 
> than writing more C plumbing stuff..

Do you have preference about what language of script we used? I actually
hesitated to introduce my Python script to git.

I can build some script extension for git just like the one I did for
sparse, is that some thing you want to see? 

Chris

