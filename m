From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 15:46:36 -0500
Message-ID: <458AF2AC.4080304@garzik.org>
References: <4589F9B1.2020405@garzik.org> <Pine.LNX.4.60.0612212135230.5551@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 21:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxUoO-00030u-0R
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbWLUUqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 15:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423083AbWLUUqk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 15:46:40 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44758 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423078AbWLUUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 15:46:39 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1GxUoH-0001sj-Lq; Thu, 21 Dec 2006 20:46:38 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0612212135230.5551@poirot.grange>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35087>

Guennadi Liakhovetski wrote:
> On Wed, 20 Dec 2006, Jeff Garzik wrote:
> 
>> I refreshed my git intro/cookbook for kernel hackers, at
>> http://linux.yyz.us/git-howto.html
> 
> Very nice, thanks! A couple of remarks from an absolute git newbie:
> 
> 1. I heard "git am" is supposed to supersede apply-mbox

Hey, that's pretty neat.  Glad you told me, this should improve my 
workflow a bit.


> 2. What I often have problems with is - what to do if git spits at me a 
> bunch of conflict messages after a seemingly safe pull or similar. Don't 
> know if you want to cover those points but "git troubleshooting" would 
> definitely be a valuable document.

Agreed.

	Jeff
