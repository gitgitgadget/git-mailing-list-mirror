From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Wed, 31 Aug 2005 12:56:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508311244410.23242@iabervon.org>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
 <7voe7ehb7z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:53:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAVp7-0000IX-QP
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 18:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVHaQw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVHaQw1
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 12:52:27 -0400
Received: from iabervon.org ([66.92.72.58]:42511 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964872AbVHaQw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 12:52:26 -0400
Received: (qmail 6479 invoked by uid 1000); 31 Aug 2005 12:56:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Aug 2005 12:56:11 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe7ehb7z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7977>

On Tue, 30 Aug 2005, Junio C Hamano wrote:

> Dan, I really really *REALLY* wanted to try this out in "pu"
> branch and even was about to rig some torture chamber for
> testing before applying the patch, but you got the shiny blue
> bat X-<.

I'll send a replacement with the settings correct.

> A patch to SubmittingPatches, MUA specific help section for
> users of Pine 4.63 would be very much appreciated.

Ah, it looks like a recent version changed the default behavior to do the 
right thing, and inverted the sense of the configuration option. (Either 
that or Gentoo did it.) So you need to set the 
"no-strip-whitespace-before-send" option, unless the option you have is 
"strip-whitespace-before-send", in which case you should avoid checking 
it.

I don't actually have things set up for preparing patches from work, 
although I can resend the patches I prepared earlier.

	-Daniel
*This .sig left intentionally blank*
