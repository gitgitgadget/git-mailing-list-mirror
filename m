From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 10:54:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1596562044-1237542892=:10279"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbRQ-0005Xq-1Q
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZCTJw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZCTJw5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:52:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:48991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311AbZCTJw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:52:56 -0400
Received: (qmail invoked by alias); 20 Mar 2009 09:52:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 20 Mar 2009 10:52:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HHm0zmDlHUgVTxZalso7pfLSs/M7lJTROxYM2y9
	05AYdwPPiqukPc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113927>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1596562044-1237542892=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 20 Mar 2009, Wincent Colaiuta wrote:

> El 20/3/2009, a las 10:29, Johannes Schindelin escribió:
> 
> >
> >Often, it is quite interesting to inspect the branch tracked by a given
> >branch.  This patch introduces a nice notation to get at the tracked
> >branch: 'BEL<branch>' can be used to access that tracked branch.
> >
> >A special shortcut 'BEL' refers to the branch tracked by the current branch.
> >
> >Suggested by Pasky and Shawn.
> 
> What does BEL actually stand for? I read Shawn's suggestion, but it's not
> immediately clear to me what "BEL" means.

It is the ASCII "bell" character, 007 (I always wanted to write that 
magic identifier into a patch).

FWIW you could type it in a regular ANSI terminal using Control-v 
Control-g.

Ciao,
Dscho

--8323328-1596562044-1237542892=:10279--
