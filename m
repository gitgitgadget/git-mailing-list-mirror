From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Restructure the tag object
Date: Sun, 10 Jun 2007 19:35:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101934550.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <Pine.LNX.4.64.0706100741310.4059@racer.site> <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
 <200706101347.57023.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSJ8-0004GX-6w
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 20:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbXFJSid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 14:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbXFJSid
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 14:38:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:36163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754079AbXFJSic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 14:38:32 -0400
Received: (qmail invoked by alias); 10 Jun 2007 18:38:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 10 Jun 2007 20:38:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mp/covfPmtxjWkD+IQExW+m7n0ULEDhaL21EQ2u
	H5J4nQwKOu+mLJ
X-X-Sender: gene099@racer.site
In-Reply-To: <200706101347.57023.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49753>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> Johan Herland (4):
>       Make tag names (i.e. the tag object's "tag" line) optional
>       Introduce optional "keywords" on tag objects
>       Documentation/git-mktag: Document the changes in tag object structure
>       git-mktag tests: Expand on mktag selftests according to the new tag object structure

Much nicer, thank you.

Ciao,
Dscho
