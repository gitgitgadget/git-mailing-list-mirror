From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 03 Nov 2007 16:30:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711031627000.21255@xanadu.home>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
 <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:30:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPdj-0000Nc-HY
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbXKCUa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756042AbXKCUa3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:30:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41313 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbXKCUa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:30:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQY00F2O6ARWD20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Nov 2007 16:30:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63308>

On Sat, 3 Nov 2007, Linus Torvalds wrote:

> 
> 
> On Sat, 3 Nov 2007, Nicolas Pitre wrote:
> > 
> > Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> 
> I mostly like this, but can we please just use "MB/kB" instead of 
> "MiB/KiB"?
> 
> I hope it was some kind of joke on crazy EU bureaucrats that just wasn't 
> caught in time.

I don't care either ways.  In fact my own preference is for MB/kB, but 
if I had used that first I'm sure someone else would have asked for the 
purist notations.


Nicolas
