From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Thu, 29 May 2008 17:05:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291704280.13507@racer.site.net>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <alpine.DEB.1.00.0805291422210.13507@racer.site.net> <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1304140824-698710359-1212077159=:13507"
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu May 29 18:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1kfc-00004x-Ai
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 18:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYE2QHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYE2QHJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 12:07:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753660AbYE2QHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 12:07:08 -0400
Received: (qmail invoked by alias); 29 May 2008 16:07:06 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp022) with SMTP; 29 May 2008 18:07:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fjoRQEVyftoAbSVhNRG7GIr56tItmI5s5ykMs7M
	nLSCGe25IbcHE3
X-X-Sender: gene099@racer.site.net
In-Reply-To: <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83213>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1304140824-698710359-1212077159=:13507
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 29 May 2008, Wincent Colaiuta wrote:

> El 29/5/2008, a las 15:22, Johannes Schindelin escribió:
>
> >Probably you are not enoyed enough to just go and fix it.
> 
> No, that's not actually the case. In reality I was pleasantly surprised 
> when Junio commented that "perhaps we should remove" that file;

You misunderstood me.  I was not talking about "fixing" it by removing the 
file, and papering over the UTF-8 issue on HFS+.

I was talking about fixing it by handling UTF-8 in a way that is 
compatible with (maybe stupid, but that cannot be helped) HFS+.

Ciao,
Dscho
---1304140824-698710359-1212077159=:13507--
