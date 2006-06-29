From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 15:06:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291505070.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <20060629035849.GA30749@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291154510.1213@localhost.localdomain>
 <20060629180719.GB4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291444370.1213@localhost.localdomain>
 <20060629185759.GB6704@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 21:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1qW-00070h-KT
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWF2TGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 15:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWF2TGd
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 15:06:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46215 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932242AbWF2TGc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 15:06:32 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M00946YEV18Y0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 15:06:32 -0400 (EDT)
In-reply-to: <20060629185759.GB6704@coredump.intra.peff.net>
X-X-Sender: nico@localhost.localdomain
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22892>

On Thu, 29 Jun 2006, Jeff King wrote:

> On Thu, Jun 29, 2006 at 02:48:23PM -0400, Nicolas Pitre wrote:
> 
> > Dare to test it?  I provided you with most of the code difference 
> > already.
> 
> See my other mail. Unless I did something horribly wrong, caching full
> windows is largely useless.

... on your special photo repository I agree.

I'm still unconvinced for large repos though.


Nicolas
