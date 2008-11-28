From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 12:51:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811281248230.30769@pacific.mpi-cbg.de>
References: <87ej0wwptn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Nov 28 12:44:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L61lp-0002GT-Bu
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 12:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYK1Lm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 06:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbYK1Lm4
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 06:42:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:34217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752449AbYK1Lm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 06:42:56 -0500
Received: (qmail invoked by alias); 28 Nov 2008 11:42:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 28 Nov 2008 12:42:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+onEkYtUionJ/udCF1RnuoPht5fifBycwcaEHAwP
	Oi/uO5wChBohQU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ej0wwptn.fsf@jidanni.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101872>

Hi,

On Fri, 28 Nov 2008, jidanni@jidanni.org wrote:

> Gentlemen, it's my first git-clone,
> $ git-clone git://git.debian.org/git/pkg-fso/files.git
> and I'm disappointed to find the timestamps of the files created are
> all now and not the date of last edit.

You are mistaken to be disappointed.  Granted, to a hammer, everything 
looks like a nail.  But it might make more sense to be gentle, and insert 
the syringe by hand.  Maybe it will get less painful that way, too.

In other words, do not be surprised when a source code management tool 
turns out to be lousy at recreating meta-data -- which has as much to do 
with source code than a syringe with a nail.

Hth,
Dscho
