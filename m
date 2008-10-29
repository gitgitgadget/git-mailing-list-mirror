From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff
 --cached'.
Date: Wed, 29 Oct 2008 18:03:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:57:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEMd-0003li-Ow
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbYJ2Q4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYJ2Q4d
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:56:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:41490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753802AbYJ2Q4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:56:32 -0400
Received: (qmail invoked by alias); 29 Oct 2008 16:56:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 29 Oct 2008 17:56:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TxbJTNY/TtR0e/FWab9JfQQEsjYryIY+RGLO4Th
	8HEZAJrjowr8Ke
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99381>

Hi,

On Wed, 29 Oct 2008, Wincent Colaiuta wrote:

> Git already has too many commands. Adding more is not going to clear up 
> newbie confusion, and will only waste time because people will complain 
> about it and ask why there is this kind of duplication.

I completely disagree.  If the existing set of commands causes confusion, 
we need to deprecate those parts and add new commands.  Even if we have a 
ton of commands already.

It does not need to hurt, either.  Just think of init-db.  Ever heard of 
it?  We still have it, yet it is not relevant.

Ciao,
Dscho
