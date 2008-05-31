From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sun, 1 Jun 2008 00:19:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de> <20080531182555.1646.47950.stgit@localhost.localdomain> <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1641225979-1212275944=:13507"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 01:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2aOs-00032m-0v
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 01:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbYEaXUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756610AbYEaXUa
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 19:20:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:54393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755830AbYEaXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 19:20:12 -0400
Received: (qmail invoked by alias); 31 May 2008 23:20:09 -0000
Received: from R3073.r.pppool.de (EHLO none.local) [89.54.48.115]
  by mail.gmx.net (mp006) with SMTP; 01 Jun 2008 01:20:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EcT9C3KEEmbL90ycvJWYpeyLwec5z3W4aLxYLOV
	2M6QkCKQxzLv65
X-X-Sender: gene099@racer.site.net
In-Reply-To: <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83414>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1641225979-1212275944=:13507
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 31 May 2008, Wincent Colaiuta wrote:

> El 31/5/2008, a las 20:28, Jakub Narebski escribió:
> 
> > Testing if gitweb handles filenames with spaces, filenames with plus 
> > sign ('+') which encodes spaces in CGI parameters (in URLs), and 
> > filenames with Unicode characters should be handled by gitweb tests.
> >
> > Those files are remainder of the time when gitweb was project on its 
> > own, not a part of git (with its testsuite).
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Ack.

And I thought "Ack" was reserved for the people who are considered the 
primary authors of the patched code...

Ciao,
Dscho

--8323329-1641225979-1212275944=:13507--
