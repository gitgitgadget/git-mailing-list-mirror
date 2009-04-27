From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: How is git used as other than the project's version control?
Date: Mon, 27 Apr 2009 18:55:38 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 00:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZkW-0000io-FC
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbZD0W4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZD0W4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:56:24 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:37510 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZD0W4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 18:56:23 -0400
X-ASG-Debug-ID: 1240872983-028503450002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP id 4ACEA3A44B7
	for <git@vger.kernel.org>; Mon, 27 Apr 2009 18:56:23 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id XofUG16tZlgHmHJZ for <git@vger.kernel.org>; Mon, 27 Apr 2009 18:56:23 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 18:55:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: How is git used as other than the project's version control?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How is git used as other than the project's version control?
Thread-Index: AcnHi0hySTsY6UtJRa+QBMqQ3hbkhw==
X-OriginalArrivalTime: 27 Apr 2009 22:55:39.0883 (UTC) FILETIME=[492CE3B0:01C9C78B]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240872983
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117725>

I'm interested in finding out how people use git "on the side", when it
is not the project's actual version control system.

I'm aware of the vague idea of using it to "go remote".

I'm sure I'll use it for non-programming topics just as an undo system.

But what about using it as a tool, wielded separately from applying
those tools to a git repository infrastructure?  For example, use it to
separate out hunks and untangle mixed work.  You could do this even if
your directory has nothing to do with git normally.  

--John
(please forgive the footer; it's not my idea nor my choice)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
