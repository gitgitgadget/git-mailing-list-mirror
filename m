From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 17:33:12 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801121732230.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <7v3at3280v.fsf@gitster.siamese.dyndns.org> <200801120157.47854.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148944103-900005539-1200155594=:8333"
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjIr-00067s-D9
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbYALQdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbYALQdR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:33:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:56884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752026AbYALQdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:33:16 -0500
Received: (qmail invoked by alias); 12 Jan 2008 16:33:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp020) with SMTP; 12 Jan 2008 17:33:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dwQpWsTWd6WkWe/JCbDbacNK6kS+2DIlBT1yhio
	MP18pEYnYqVvcK
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <200801120157.47854.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70328>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148944103-900005539-1200155594=:8333
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 12 Jan 2008, Robin Rosenberg wrote:

> lördagen den 12 januari 2008 skrev Junio C Hamano:
>
> > And where should the configuration be stored?  If a project wants to 
> > be interoperable across Linux and vfat, for example,
> 
> In the brand new ".gitconfig". It could in principle contain any config 
> option, but that would not be safe so I guess one should only allow 
> "safe" options there.

Funny: I had the same idea (.gitconfig) for the crlf issues...

Ciao,
Dscho

---1148944103-900005539-1200155594=:8333--
