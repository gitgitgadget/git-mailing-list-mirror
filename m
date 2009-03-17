From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: [PATCH] git-branch.txt: document -f correctly
Date: Tue, 17 Mar 2009 12:07:17 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A3FC05C@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@drmicha.warpmail.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljbrh-0001UT-UZ
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725AbZCQQHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757597AbZCQQHq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:07:46 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:33395 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669AbZCQQHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 12:07:45 -0400
X-ASG-Debug-ID: 1237306060-6eb600830000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id AD9472196CD; Tue, 17 Mar 2009 12:07:40 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id f7RlhKdcVOOYV37y; Tue, 17 Mar 2009 12:07:40 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 12:07:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: [PATCH] git-branch.txt: document -f correctly
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH] git-branch.txt: document -f correctly
Thread-Index: AcmnGnFz0hZ4pUzWR5Kj9KmSwybw2A==
X-OriginalArrivalTime: 17 Mar 2009 16:07:39.0987 (UTC) FILETIME=[7F157230:01C9A71A]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237306060
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113490>

===  Re: ===
BTW, I noticed that 'git-subcmd' is used everywhere in here which does
not feel right, but I followed the existing style, leaving a consistent
clean-up for a later patch. Also, typesetting is inconsistent:
We have <branch> as well as `<branch>` when the text talks about the
options. Do we have a style guide or such?
=== end ===

I would agree that being factually correct and available immediately
trumps being wrong but pretty.

As an experienced writer and editor, the documentation is something I
might hack long before I tackle the code.  I see you edited a file with
.txt extension, and some kind of markup that's not the HTML files I'm
reading.  Beyond any kind of style guide, is there a guide to the
documentation _system_ in use?

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
