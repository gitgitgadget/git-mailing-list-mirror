From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 0/9] applymbox updates and assorted trivial patches.
Date: Thu, 21 Jul 2005 02:19:06 -0400
Message-ID: <20050721061906.GN20369@mythryan2.michonline.com>
References: <7vy881dpii.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 08:19:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvUOv-0000GL-VC
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 08:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVGUGTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 02:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGUGTP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 02:19:15 -0400
Received: from mail.autoweb.net ([198.172.237.26]:42170 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261642AbVGUGTO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2005 02:19:14 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DvUOh-0006Me-CL; Thu, 21 Jul 2005 02:19:07 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DvUWi-0000vp-00; Thu, 21 Jul 2005 02:27:24 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DvUOg-0007iV-N0; Thu, 21 Jul 2005 02:19:06 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy881dpii.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2005 at 04:30:29PM -0700, Junio C Hamano wrote:
> Since I rebase my repostitory to fix up the history often, I
> needed a reliable way to preserve authorship information when I
> export the patches via format-patch and slurp them via applymbox.

Is it just me, or does format-patch lose the commit comments during
export?  I haven't experimented with your new patches yet - and since
I'm at OLS and playing with Git during my free time, my brain is pretty
much shut down now - so if you have happen to have fixed that, thanks!

[...]

> After they are accepted, I will forward these trivially correct
> patches I saw on the list, using the enhanced format-patch; they
> are expected to be processed with the new applymbox as a
> practice; by doing this I am also ACKing these patches:
> 
>   [PATCH] debian/ fixes

I have more debian/ fixes - I cc:ed you on them since I see you are
collecting things this week.

-- 

Ryan Anderson
  sometimes Pug Majere
