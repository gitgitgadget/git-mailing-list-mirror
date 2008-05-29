From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Thu, 29 May 2008 14:22:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291422210.13507@racer.site.net>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1304140824-102291580-1212067369=:13507"
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu May 29 15:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1i7i-0005Md-3C
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 15:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYE2NX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 09:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYE2NX7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 09:23:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751183AbYE2NX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 09:23:58 -0400
Received: (qmail invoked by alias); 29 May 2008 13:23:57 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp008) with SMTP; 29 May 2008 15:23:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m5jUS8IambvPM7oDtDQ8u059L5hMEpUZv8IXUuk
	k4wAxdMggrKEvu
X-X-Sender: gene099@racer.site.net
In-Reply-To: <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83199>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1304140824-102291580-1212067369=:13507
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 28 May 2008, Wincent Colaiuta wrote:

> El 28/5/2008, a las 8:12, Junio C Hamano escribió:
>
> >Perhaps we should remove the infamous gitweb/test/Märchen file while we 
> >are at it?  I do not think the file is ever used.
> 
> I for one would love to see it go, seeing as I live in the ghetto that 
> is HFS+ and am constantly annoyed by it cluttering up my status output 
> with spurious content.
> 
> I understand that the reason it lives in the tree is precisely to 
> discover problems with such filesystems, but the problem is well and 
> truly discovered by now and I'd much rather see this kind of thing 
> tested from within the test suite rather than every time I do "git 
> status" or "git checkout".

Probably you are not enoyed enough to just go and fix it.

Ciao,
Dscho

---1304140824-102291580-1212067369=:13507--
