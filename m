From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 16 Jul 2008 04:30:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160428590.2841@eeepc-johanness>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness> <alpine.LFD.1.10.0807151851090.2835@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 04:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIwmt-0003zl-Fv
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 04:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbYGPC3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 22:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbYGPC3k
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 22:29:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:47554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753373AbYGPC3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 22:29:40 -0400
Received: (qmail invoked by alias); 16 Jul 2008 02:29:38 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp046) with SMTP; 16 Jul 2008 04:29:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KoYpamS3KaUVZXcnH/xMAC3fTpM2eKSInpJqhNH
	0Dj+j3jJ1qHNzK
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.LFD.1.10.0807151851090.2835@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88631>

Hi,

On Tue, 15 Jul 2008, Linus Torvalds wrote:

> On Wed, 16 Jul 2008, Johannes Schindelin wrote:
> > 
> > Of course, you can name it as you want.  But I thought that the name 
> > "rebase" applies as well: the patches are rebased from somewhere else 
> > on top of HEAD :-)
> 
> Well, the original thing was not rebasing, it was patch application. You 
> could _perhaps_ call that "rebasing" from another tree, but that's a 
> stretch.

Hey, I do not insist on that name.  I just explained why I thought it was 
okay even for am.  If you know a better name, just tell me, and I'll adapt 
the patch in no time (at least as long as I am awake).

Ciao,
Dscho
