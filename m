From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 12:30:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 18:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7F8-0003BR-Mb
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWHRQan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWHRQan
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:30:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57309 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751409AbWHRQam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:30:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4700E36CJ5ZQ30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Aug 2006 12:30:41 -0400 (EDT)
In-reply-to: <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25675>

On Fri, 18 Aug 2006, Jon Smirl wrote:

> I attached Shawn's code. He is gone until Monday and can't defend it.

I will have a look at it next week as I'll be gone for the weekend as 
well.

> Do note that I am running this on the Mozilla CVS which is over 10
> years old. Some of the files have over 2,000 deltas. I average 10
> deltas per file but the distribution is not at all even. Many files
> get checked-in and never changed, for example 1000's of images.

This is IMHO more evidence that something is wrong with the results 
you obtained.


Nicolas
