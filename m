From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Move redo merge code in a function
Date: Sun, 23 Mar 2008 23:26:38 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232322310.4353@racer.site>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1329480014-1206311201=:4353"
Cc: git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYeu-0000pt-GG
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbYCWW0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbYCWW0j
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:57094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754167AbYCWW0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:26:38 -0400
Received: (qmail invoked by alias); 23 Mar 2008 22:26:36 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp042) with SMTP; 23 Mar 2008 23:26:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Yd58xqzhYB799M6ynEeDZTEeyOO8gOIxqUkzPZ7
	amzIyNBwkzkaon
X-X-Sender: gene099@racer.site
In-Reply-To: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77967>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1329480014-1206311201=:4353
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Mar 2008, Jörg Sommer wrote:

> 
> Signed-off-by: Jörg Sommer <joerg@alea.gnuu.de>

I like the patch, but the commit message is not really meaningful if you 
do not read the patch.  Maybe you want to prefix it with "rebase -i:"?  
And _just_ maybe you want to give an explanation what you want to do with 
it?

(For reference, I think the recent patch series by Linus is a _wonderful_ 
example how to do it: it has a very informative cover letter, and each 
patch tells you more about what and why, leaving the how mostly to the 
patch.  Basically, it is a pleasure to read (and understand):

http://article.gmane.org/gmane.comp.version-control.git/77827)

Ciao,
Dscho
--8323584-1329480014-1206311201=:4353--
