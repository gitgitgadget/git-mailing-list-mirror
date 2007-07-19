From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 18:30:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191829530.14781@racer.site>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
 <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site>
 <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com>
 <Pine.LNX.4.64.0707191642270.14781@racer.site>
 <6C96EBA9-CDCE-40EA-B0EC-F9195DBE83DB@silverinsanity.com>
 <Pine.LNX.4.64.0707191715000.14781@racer.site>
 <CC669745-4434-478E-9A24-E474071578C6@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:30:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBZpr-00084F-KY
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965812AbXGSRak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965800AbXGSRaj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:30:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:59306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965775AbXGSRah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 13:30:37 -0400
Received: (qmail invoked by alias); 19 Jul 2007 17:30:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 19 Jul 2007 19:30:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198BU8kFmt8TakvRbFwpwTE58yYsjJ+fGzijBzRYK
	yUxjdMDN8RI3YG
X-X-Sender: gene099@racer.site
In-Reply-To: <CC669745-4434-478E-9A24-E474071578C6@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53008>

Hi,

On Thu, 19 Jul 2007, Brian Gernhardt wrote:

> On Jul 19, 2007, at 12:17 PM, Johannes Schindelin wrote:
> 
> > Alas, we already have such a marker.  It is called ".gitignore", and has
> > been ignored by _you_.  There is _nothing_ wrong, from a technical
> > standpoint, to call this marker ".gitignore", and it is _also_ not wrong
> > to put this marker into the file system _in addition_ to the index.
> > 
> > So go and add your directories via that marker, and _be done with it_.
> 
> But this alters the content of the directory away from what I want it to be,
> namely empty.  You aren't addressing the concept of tracking an empty
> directory, you're just saying you won't do it.

OMG last time I checked, my _empty_ directory contained "." and "..".  
What do I do now?

Really,
Dscho
