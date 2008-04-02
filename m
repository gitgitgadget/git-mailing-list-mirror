From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug in make install
Date: Wed, 2 Apr 2008 21:16:43 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804022116080.4008@racer.site>
References: <JYPQSO$FF146173479D39756CA6CA952130001D@poste.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Marco Maggi <marco.maggi-ipsu@poste.it>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9PR-00005I-KI
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759652AbYDBUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761362AbYDBUQa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:16:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:57447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761345AbYDBUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:16:29 -0400
Received: (qmail invoked by alias); 02 Apr 2008 20:16:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 02 Apr 2008 22:16:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1Ep5Odia1Nkv/KjzRPd/RXHyNbELkx6ZmNF//op
	OTdipAjmg6zsbC
X-X-Sender: gene099@racer.site
In-Reply-To: <JYPQSO$FF146173479D39756CA6CA952130001D@poste.it>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78712>

Hi,

On Wed, 2 Apr 2008, Marco Maggi wrote:

> Do not bother me asking why I put "." in CDPATH.

We will probably not bother.  But we mention that exporting CDPATH makes 
absolutely zero sense.

Ciao,
Dscho
