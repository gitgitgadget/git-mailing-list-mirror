From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: git-forest on msysgit
Date: Mon, 9 Mar 2009 10:59:05 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A116139@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A115F15@EXCHANGE.trad.tradestation.com> <alpine.DEB.1.00.0903070352580.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LggyG-0003x1-NP
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZCIO7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZCIO7U
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 10:59:20 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:55885 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZCIO7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 10:59:19 -0400
X-ASG-Debug-ID: 1236610756-4039033f0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 469D01FDF87; Mon,  9 Mar 2009 10:59:16 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id JPvq2cBZrg7X5Lyg; Mon, 09 Mar 2009 10:59:16 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Mar 2009 10:59:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: git-forest on msysgit
In-Reply-To: <alpine.DEB.1.00.0903070352580.10279@pacific.mpi-cbg.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-forest on msysgit
Thread-Index: Acmez9+w0OlGhQwrTCKuq3GtxU9PQwB9yxZw
X-OriginalArrivalTime: 09 Mar 2009 14:59:15.0262 (UTC) FILETIME=[9D2C1DE0:01C9A0C7]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236610756
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112699>

>> Note: this is pretty much obviously the wrong mailing list for 
msysGit-related issues.

This is the list where I get friendly and useful answers as well as
fruitful discussions, and I've seen Windows and MSYSget in particular
mentioned many times when reviewing the threads.

>> You can try recompiling git-svn.  Maybe I forgot to commit a file.

I've not delved into the source code yet, but some day...

>> > I wonder if I can just copy it from somewhere, like someone's Linux

>> > build?

>> How do you expect a Linux-specific binary object to be usable on
Windows?

Because it's the Perl inside MSys/Cigwin.  Isn't the POSIX layer like
Wine in reverse?

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
