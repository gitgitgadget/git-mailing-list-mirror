From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 20:22:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-138548101-1170962537=:22628"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFEqc-0002Xa-3l
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423255AbXBHTWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423259AbXBHTWT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:22:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:42450 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423255AbXBHTWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:22:18 -0500
Received: (qmail invoked by alias); 08 Feb 2007 19:22:17 -0000
X-Provags-ID: V01U2FsdGVkX1+Sx4wIHGaSt1sGgmpr+6BfMuwyPafATFNoAS9iKz
	WHsA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39075>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-138548101-1170962537=:22628
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 8 Feb 2007, Santi Béjar wrote:

>  when a reflog entry do not have a reflog message the refs@{num} syntax 
> gives a different result than with 'git log -g'. Actually 'git log -g' 
> just skips this ref.

I could be that some older git version produces empty messages. But I'd 
regard the empty messages to be the problem. Or is the current Git version 
still producing such entries?

Ciao,
Dscho

---1148973799-138548101-1170962537=:22628--
