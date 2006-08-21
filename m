From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 22:27:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608212227040.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com> 
 <20060821101346.GA527@diku.dk> <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-814219772-1156192078=:28360"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 22:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGNT-0008Go-Tq
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWHUU2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWHUU2E
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:28:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:27346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750970AbWHUU2D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 16:28:03 -0400
Received: (qmail invoked by alias); 21 Aug 2006 20:27:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 21 Aug 2006 22:27:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@bitplanet.net>
In-Reply-To: <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25815>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-814219772-1156192078=:28360
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 21 Aug 2006, Kristian Høgsberg wrote:

> Thanks to all who reviewed the patch, here's an updated version which
> should address all issues.

I would have preferred the use of path_list instead of rolling your own 
thing with qsort(), but oh well.

Rest looks fine to me.

Ciao,
Dscho

---1148973799-814219772-1156192078=:28360--
