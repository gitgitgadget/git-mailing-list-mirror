From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff
 --cached'.
Date: Wed, 29 Oct 2008 16:48:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291647280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029152202.GA10029@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:44:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvDBj-0003Kd-Rb
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYJ2Pkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYJ2Pkz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:40:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:52681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752986AbYJ2Pkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:40:55 -0400
Received: (qmail invoked by alias); 29 Oct 2008 15:40:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 29 Oct 2008 16:40:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uvXMbaCtugU4lze/eyoi+9VauZSL8NVfuBztxvS
	/sBhoCVA1R9O9d
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081029152202.GA10029@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99374>

Hi,

On Wed, 29 Oct 2008, Stephan Beyer wrote:

> For me, a "git staged" feels wrong without a "git stage" (alias for "git 
> add") and "git unstage <file>" (alias for "git reset <file>"). And I 
> think the list of examples can easily be continued.

http://article.gmane.org/gmane.comp.version-control.git/99340

Thanks,
Dscho
