From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git
 directory
Date: Mon, 5 May 2008 12:36:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051234260.30431@racer>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1342725-1209987372=:30431"
Cc: git@vger.kernel.org, jjengla@sandia.gov
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon May 05 13:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsz0D-0007iR-4a
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 13:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYEELgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 07:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYEELgR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 07:36:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:35900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbYEELgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 07:36:16 -0400
Received: (qmail invoked by alias); 05 May 2008 11:36:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp017) with SMTP; 05 May 2008 13:36:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194+cIjZXV4Iav7Nwq7mHB/+V/Zf0qtjCy2x39BuZ
	BFpsMkSw8jwk4B
X-X-Sender: gene099@racer
In-Reply-To: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81268>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1342725-1209987372=:30431
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 May 2008, Jörg Sommer wrote:

> Signed-off-by: Jörg Sommer <joerg@alea.gnuu.de>

Am I the only one wondering what the subject tries to tell me?

>  contrib/hooks/setgitperms.perl |    2 +-

This tells me more...

Please keep in mind that the commit log is meant to demonstrate the 
_intention_ of the patches.  If you do not say _what_ is affected by the 
change, you only confuse the readers.

Ciao,
Dscho
--8323329-1342725-1209987372=:30431--
