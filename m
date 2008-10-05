From: Asheesh Laroia <git@asheesh.org>
Subject: Re: [ANNOUNCE] cgit 0.8
Date: Sun, 5 Oct 2008 13:49:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0810051346290.27691@alchemy.localdomain>
References: <8c5c35580810051310u60859afcvf38845244308cd23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmb4c-0004L5-9T
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYJEVWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbYJEVWT
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:22:19 -0400
Received: from rose.makesad.us ([219.105.37.19]:35475 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797AbYJEVWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:22:18 -0400
X-Greylist: delayed 1936 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Oct 2008 17:22:18 EDT
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 3AD2CA0127;
	Sun,  5 Oct 2008 16:49:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id BE3CC6E4BB;
	Sun,  5 Oct 2008 13:49:57 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <8c5c35580810051310u60859afcvf38845244308cd23@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97536>

On Sun, 5 Oct 2008, Lars Hjemli wrote:

> cgit-0.8, another webinterface for git, is now available.
>
> clone:   git://hjemli.net/pub/git/cgit
> browse:  http://hjemli.net/git/cgit

This is great!

I'm curious - is there any interest in the cgit world in providing gitweb 
URL compatibility?  That way, migrations from gitweb to cgit would not 
break links.  I know that's something we've been thinking through at 
code.creativecommons.org; gitweb has been a big load on that web server, 
but (re-)switching to cgit would mean invalidating people's bookmarked 
links again.

Also, Tv or other gitosis maintainers: Is there any interest in supporting 
cgit as easily as gitweb is supported in gitosis?

If the answer to both is "We don't personally care about it, but patches 
are welcome, " that'll be okay, but obviously I'm hoping for something 
else. (-:

Either way, thanks a bundle to all who work on cgit!  (And is this the 
canonical place to discuss it?)

-- Asheesh.

-- 
Seleznick's Theory of Holistic Medicine:
 	Ice Cream cures all ills.  Temporarily.
