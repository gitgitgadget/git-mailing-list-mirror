From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Fri, 16 May 2008 11:25:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161125320.30431@racer>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>  <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-854262733-1210933557=:30431"
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx98-0002hV-IX
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYEPKZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYEPKZw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:25:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:54211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751742AbYEPKZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:25:52 -0400
Received: (qmail invoked by alias); 16 May 2008 10:25:50 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp007) with SMTP; 16 May 2008 12:25:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tKShoZaXtdceMHVHU550lFx1cKnTuyVYJqPcKnS
	YyUnZa8r2qfi8D
X-X-Sender: gene099@racer
In-Reply-To: <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82268>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-854262733-1210933557=:30431
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 15 May 2008, André Goddard Rosa wrote:

> >>  This patch will make git a little more human friendly, reporting "file.txt: has local changes".
> >
> > Documentation/git-checkout.txt should also change in this case,
> > otherwise users will see different output to that described and
> > possibly get confused if following along with the examples.
> >
> 
> I like the idea too.

No comment on the concern that it might break people's scripts?  None?

Ciao,
Dscho

--8323329-854262733-1210933557=:30431--
