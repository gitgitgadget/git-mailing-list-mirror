From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add line-wrapping guidelines to the coding style
 documentation
Date: Wed, 14 Nov 2007 17:19:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711141717570.4362@racer.site>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:20:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsLuE-0007Yq-FN
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 18:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426AbXKNRTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 12:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbXKNRTq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 12:19:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:45332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756281AbXKNRTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 12:19:46 -0500
Received: (qmail invoked by alias); 14 Nov 2007 17:19:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 14 Nov 2007 18:19:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183K11Wzw83B7o88fABZZ4PDdn4+GFiqxycm4rnpi
	0hCBak0VYpsTKN
X-X-Sender: gene099@racer.site
In-Reply-To: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64991>

Hi,

On Wed, 14 Nov 2007, Wincent Colaiuta wrote:

> Help new contributors by providing some advice about line-wrapping; the 
> advice basically boils down to "use 80-characters minus some slop as a 
> rule of thumb", but also "use common sense", and "avoid gratuitous 
> rewrapping".

We already have this:

 - We try to keep to at most 80 characters per line.

Besides, is it really necessary to be as explicit as you word it?  IOW is 
this patch needed?

Because if we go down that road, we might very well end up with a 
CodingGuidelines document that is larger than git's source code.

Ciao,
Dscho
