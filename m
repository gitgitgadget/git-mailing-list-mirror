From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 20:32:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802102032211.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <alpine.LFD.1.00.0802081250240.2732@xanadu.home> <200802091525.36284.kendy@suse.cz> <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com> <alpine.LSU.1.00.0802101207330.11591@racer.site>
 <ee77f5c20802100846g10937a49m4901f88a70a6de0@mail.gmail.com> <alpine.LSU.1.00.0802101649110.11591@racer.site> <alpine.LFD.1.00.0802101443240.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:33:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIrY-0001vS-0w
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbYBJUcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYBJUcl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:32:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:38232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753790AbYBJUck (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:32:40 -0500
Received: (qmail invoked by alias); 10 Feb 2008 20:32:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp002) with SMTP; 10 Feb 2008 21:32:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f5AI6/YLftP7HQaWIETuYxFAAOdbNJUBPr1K47e
	v+18RNF7LoBNx2
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802101443240.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73401>

Hi,

On Sun, 10 Feb 2008, Nicolas Pitre wrote:

> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> 
> > Resolving 34549 deltas...
> >  100% (34549/34549) done
> 
> What Git version is this?
> 
> You better try out 1.5.4 for packing comparisons.  It produces slightly 
> tighter packs than 1.5.3.

Ooops.  I thought I updated, but no: 1.5.3.6.2835.gf9ebf

Ciao,
Dscho
