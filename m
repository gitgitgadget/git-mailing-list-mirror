From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Abort early if not being sourced under bash.
Date: Fri, 8 Feb 2008 21:14:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082113410.11591@racer.site>
References: <200802082310.34398.ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-692816143-1202505278=:11591"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNaYr-0001pJ-6N
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYBHVOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbYBHVOd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:14:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:55392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750894AbYBHVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:14:32 -0500
Received: (qmail invoked by alias); 08 Feb 2008 21:14:29 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 08 Feb 2008 22:14:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c/SEvWDecfVKZzLijazEdO/zL06hIHVDiq3JJMn
	7fdXWOHTK19O2B
X-X-Sender: gene099@racer.site
In-Reply-To: <200802082310.34398.ville.skytta@iki.fi>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73146>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-692816143-1202505278=:11591
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Feb 2008, Ville Skyttä wrote:

> Subject: [PATCH] Abort early if not being sourced under bash.

Please do not repeat the subject.  And prepend "git-completion: " so 
people can see from the subject already what this patch is about.

As for the patch, yeah, I think it should go in.

Ciao,
Dscho
---1463811741-692816143-1202505278=:11591--
