From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 15:34:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041534000.4174@racer.site>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
 <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdRdK-0006bw-L3
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXJDOYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbXJDOYl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:24:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:41314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756165AbXJDOYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 10:24:40 -0400
Received: (qmail invoked by alias); 04 Oct 2007 14:24:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 04 Oct 2007 16:24:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zr2MPPShzb/Ag5VFBjDgf72QX2uBAwKvOnBzEf1
	0pnlTq96v0OTfH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59955>

Hi,

On Thu, 4 Oct 2007, Junio C Hamano wrote:

>  * --cached means work only on index and ignore work tree.

I guess I could live with "--staged" as a synonym for "--cached" (and 
maybe deprecating "--cached").

Ciao,
Dscho
