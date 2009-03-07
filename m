From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using Git with windows
Date: Sat, 7 Mar 2009 03:50:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070350070.10279@pacific.mpi-cbg.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E18@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2100675273-1236394252=:10279"
Cc: git@vger.kernel.org, tariq.hassanen@gmail.com
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfmeh-0001cC-Lj
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZCGCtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbZCGCtW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:49:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:43926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751021AbZCGCtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:49:21 -0500
Received: (qmail invoked by alias); 07 Mar 2009 02:49:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 07 Mar 2009 03:49:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9V1R85cq9F+54rGfByk/YzKEaXL6jk9MquCKWxa
	jNILRjSEzCOC1k
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115E18@EXCHANGE.trad.tradestation.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112507>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2100675273-1236394252=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 6 Mar 2009, John Dlugosz wrote:

> I can think of two differences:  Line endings have been mentioned already.

And I have addressed that already, did I not?

> But, and I was wondering this already anyway, does the Windows git know 
> that the file system is case insensitive but case preserving? That is, 
> does it just ignore the issue, is there logic to cope with that better? 
> If so, that would be missing if you ran it in the Linux VM. (Unless it 
> checks the file system capabilities rather than the OS it is running 
> under)

AFAIR Git recognizes case-insensitive file systems as such.

Hth,
Dscho

--8323328-2100675273-1236394252=:10279--
