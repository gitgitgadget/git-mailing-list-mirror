From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: print the new and old ref when fast-forwarding
Date: Sat, 25 Feb 2006 21:08:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602252107110.17999@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44003D6D.2010406@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1772496379-1140898117=:17999"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 25 21:08:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FD5ij-0006zw-KD
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 21:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWBYUIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWBYUIm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 15:08:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42473 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161098AbWBYUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 15:08:41 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 137831D09;
	Sat, 25 Feb 2006 21:08:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 06D3AAD8;
	Sat, 25 Feb 2006 21:08:38 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CFF71AD5;
	Sat, 25 Feb 2006 21:08:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
In-Reply-To: <44003D6D.2010406@etek.chalmers.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16762>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1772496379-1140898117=:17999
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 25 Feb 2006, Lukas Sandström wrote:

> This is useful when you check out new changes with gitk.
> Just copy/paste the old ref into gitk from the terminal.

Why does "gitk ORIG_HEAD..HEAD" not work? (It also does the correct thing 
when pulling...)

Hth,
Dscho

---1148973799-1772496379-1140898117=:17999--
