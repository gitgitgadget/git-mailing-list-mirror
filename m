From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master' but should be
Date: Mon, 18 Feb 2008 19:57:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181956270.30505@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801181638500.5731@racer.site> <alpine.LSU.1.00.0801181832180.5731@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1868498188-1203364663=:30505"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRC8F-0008Uu-CA
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbYBRT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 14:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYBRT5z
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:57:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:36630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753084AbYBRT5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:57:54 -0500
Received: (qmail invoked by alias); 18 Feb 2008 19:57:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 18 Feb 2008 20:57:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Sx5sq1JASV6tU0jA9dxli7vKnHJ5rGHx7NFW1Qc
	1cBMBclQdbwrdC
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801181832180.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74338>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1868498188-1203364663=:30505
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 18 Jan 2008, Johannes Schindelin wrote:

> Grégoire, it would help tremendously if you could come up with a test 
> case.  The description you gave did not lead to something reproducible 
> here.

It seems that I hit the problem myself recently; it only showed when there 
was more than one ref.  A fix is already in "next".

Grégoire, could you please test a current "next", just to make sure that 
the problem is now gone?

Ciao,
Dscho


---1463811741-1868498188-1203364663=:30505--
