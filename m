From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 16:43:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191642270.14781@racer.site>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
 <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site>
 <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 17:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYAi-0007Rh-VJ
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 17:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937158AbXGSPni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937118AbXGSPnh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 11:43:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:60268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934832AbXGSPng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 11:43:36 -0400
Received: (qmail invoked by alias); 19 Jul 2007 15:43:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 19 Jul 2007 17:43:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AzwJZiIZA+4QV8UVeP6BWsG/q55zlXrEZo+f5lT
	upqR7wE1jencmb
X-X-Sender: gene099@racer.site
In-Reply-To: <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52999>

Hi,

On Thu, 19 Jul 2007, Brian Gernhardt wrote:

> 
> On Jul 19, 2007, at 8:24 AM, David Kastrup wrote:
> 
> > I think that the placeholder name should rather be ".".
> 
> For what it's worth, the more this gets discussed, the more I think your 
> idea is a good one.

I do not like it at all. "." already has a very special meaning.  It is a 
_directory_, no place holder.

More and more I get the impression that this thread is just not worth it.  
The problem was solved long ago, and all that is talked about here is how 
to complicate things.

Unhappy,
Dscho
