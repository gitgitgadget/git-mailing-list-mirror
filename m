From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 21:40:05 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0612212135230.5551@poirot.grange>
References: <4589F9B1.2020405@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 21:40:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxUiA-0001MO-Pv
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 21:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082AbWLUUkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 15:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbWLUUkO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 15:40:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:48915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423082AbWLUUkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 15:40:13 -0500
Received: (qmail invoked by alias); 21 Dec 2006 20:40:07 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp054) with SMTP; 21 Dec 2006 21:40:07 +0100
X-Authenticated: #20450766
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1GxUhx-0002SA-00; Thu, 21 Dec 2006 21:40:05 +0100
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4589F9B1.2020405@garzik.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35086>

On Wed, 20 Dec 2006, Jeff Garzik wrote:

> I refreshed my git intro/cookbook for kernel hackers, at
> http://linux.yyz.us/git-howto.html

Very nice, thanks! A couple of remarks from an absolute git newbie:

1. I heard "git am" is supposed to supersede apply-mbox

2. What I often have problems with is - what to do if git spits at me a 
bunch of conflict messages after a seemingly safe pull or similar. Don't 
know if you want to cover those points but "git troubleshooting" would 
definitely be a valuable document.

Thanks
Guennadi
---
Guennadi Liakhovetski
