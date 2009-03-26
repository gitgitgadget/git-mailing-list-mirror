From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Help designing work flow
Date: Thu, 26 Mar 2009 11:38:28 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A55A05D@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com> <49B4F5A9.5060304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmrh9-0002lj-Fz
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbZCZPjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbZCZPjH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:39:07 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:50136 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZCZPjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 11:39:06 -0400
X-ASG-Debug-ID: 1238081943-1a24024f0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 49BF3237746; Thu, 26 Mar 2009 11:39:03 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id DKLlMq4Pdy3Un9C8; Thu, 26 Mar 2009 11:39:03 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Mar 2009 11:39:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Help designing work flow
In-Reply-To: <49B4F5A9.5060304@op5.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help designing work flow
Thread-Index: AcmgpZiIOpQWTB8lRt6C7jZxLJ6UmgNgwuYw
X-OriginalArrivalTime: 26 Mar 2009 15:39:02.0779 (UTC) FILETIME=[FD440CB0:01C9AE28]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1238081943
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114792>

> You can tell "git log" to only show one line of history too, but
> besides
> that, micro-details are good. You definitely want to be able to search
> the micro-details when things go awry (and they will), so you see
> exactly
> why some particular algorithm changed later.
> 

I misread that the first time.  I thought you meant that you can tell
git log to follow down the left parents only.

So, how would you do that?  List the completed merged topic nodes only,
not the detailed nodes that make it up?

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
