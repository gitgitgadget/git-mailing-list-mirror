From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 02:18:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707060217460.9789@racer.site>
References: <20070705232210.GR3492@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:19:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6cTO-0002fh-Hq
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761325AbXGFBTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761286AbXGFBTA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:19:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37535 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759913AbXGFBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:19:00 -0400
Received: (qmail invoked by alias); 06 Jul 2007 01:18:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 06 Jul 2007 03:18:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+axN9UyXOa/JxJElu3827jWRclul3A8R5wA6Epm6
	6Jb6MdflOV5fkw
X-X-Sender: gene099@racer.site
In-Reply-To: <20070705232210.GR3492@stusta.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51711>

Hi,

On Fri, 6 Jul 2007, Adrian Bunk wrote:

> git-apply{,mbox,patch} should default to doing --unidiff-zero:

But is that not dangerous? At least now the committer has some safeguard 
against this kind of mistakes. Because you can easily introduce mistakes 
that way.

Ciao,
Dscho
