From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next v3] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 22:10:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142209570.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E51A3.8050908@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1416775639-1231967448=:3586"
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LND1H-0001mD-9j
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZANVJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 16:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbZANVJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:09:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:60505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753137AbZANVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 16:09:58 -0500
Received: (qmail invoked by alias); 14 Jan 2009 21:09:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 14 Jan 2009 22:09:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Es1gtHrPEayVNTnOIrvpKpAnxTgwSA/TwiYO2K7
	NNoTsmehkCWGXQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496E51A3.8050908@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105703>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1416775639-1231967448=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Jan 2009, Tor Arne Vestbø wrote:

> The tests adds a third commit with a multi-line note. The output of
> git log -2 is then checked to see if the note lines are wrapped
> correctly, and that there's a line separator between the two commits.
> 
> Signed-off-by: Tor Arne Vestbø <tavestbo@trolltech.com>
> ---

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Maybe squash the test into the fix?

Ciao,
Dscho
--8323328-1416775639-1231967448=:3586--
