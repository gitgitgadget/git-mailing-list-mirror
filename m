From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Fri, 16 May 2008 13:22:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161322090.30431@racer>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com> <alpine.DEB.1.00.0805161125320.30431@racer> <200805161302.47865.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Fri May 16 14:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwyy6-0003bj-5T
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 14:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbYEPMWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 08:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYEPMWe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 08:22:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:46203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754165AbYEPMWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 08:22:33 -0400
Received: (qmail invoked by alias); 16 May 2008 12:22:31 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp018) with SMTP; 16 May 2008 14:22:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LbJtrUleLZH2XbsgDWWix1fV4iMwYk7jnxH4t3y
	+alwlQ4LA/LHEP
X-X-Sender: gene099@racer
In-Reply-To: <200805161302.47865.hs4233@mail.mn-solutions.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82278>

Hi,

On Fri, 16 May 2008, Holger Schurig wrote:

> > No comment on the concern that it might break people's
> > scripts?  None?
> 
> Scripts should look for exit values :-)

Clever.  And which exit value would you exactly check to see _which_ file 
needs an update?

Hth,
Dscho
