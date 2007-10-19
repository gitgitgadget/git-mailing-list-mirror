From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:02:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182301470.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net> <47181430.2080907@vilain.net>
 <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
 <20071019023426.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Symonds <dsymonds@gmail.com>, Sam Vilain <sam@vilain.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:03:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iii8h-0005aQ-0T
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760602AbXJSDC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760375AbXJSDC4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:02:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36878 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759697AbXJSDC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:02:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500L0A1SVM180@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:02:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019023426.GA14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61621>

On Thu, 18 Oct 2007, Shawn O. Pearce wrote:

> I'm leaning to making it just say "Compressing objects".  Simple,
> to the point, reasonably describes the action, and most people will
> understand what it means: "Oh, time to go get coffee if that number
> there is reeeealy big..."  :-)

I think this is sensible.


Nicolas
