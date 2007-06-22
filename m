From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 16:28:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221626450.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> <20070621131915.GD4487@coredump.intra.peff.net>
 <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
 <200706221619.30521.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 17:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1l4G-0001tf-Rl
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 17:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbXFVP2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757160AbXFVP2z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 11:28:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757150AbXFVP2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 11:28:55 -0400
Received: (qmail invoked by alias); 22 Jun 2007 15:28:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 22 Jun 2007 17:28:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fq0EU2AVflwOMXXsVQsw5hpGa9kNU9bCNDptRlS
	nCmZMdu+oNBu3G
X-X-Sender: gene099@racer.site
In-Reply-To: <200706221619.30521.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50703>

Hi,

On Fri, 22 Jun 2007, Andy Parkins wrote:

> What if two files with different filenames and content converge at some 
> point in history, then diverge again?  If git is tracking renames merely 
> by content and picks the wrong one, then the history of fileA suddenly 
> becomes the history of fileB.

This is becoming highly ethereal. Like "I could imagine that some day in 
future, some person could devise a device, that might allow you to do 
something that I can not explain, because I have not even thought of it".

IOW show me a reasonable example, and we'll talk business.

Ciao,
Dscho
