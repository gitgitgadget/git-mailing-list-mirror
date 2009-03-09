From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Help designing work flow
Date: Mon, 9 Mar 2009 11:36:12 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A116188@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com> <49B4F5A9.5060304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LghYz-00021B-5x
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZCIPhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZCIPhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:37:16 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:59594 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZCIPhP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 11:37:15 -0400
X-ASG-Debug-ID: 1236613033-3fe701c50000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 5186E1FDEC5; Mon,  9 Mar 2009 11:37:13 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id ZpDzvZVNYdGMz093; Mon, 09 Mar 2009 11:37:13 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Mar 2009 11:37:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Help designing work flow
In-Reply-To: <49B4F5A9.5060304@op5.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help designing work flow
Thread-Index: AcmgpZiIOpQWTB8lRt6C7jZxLJ6UmgAJqOfw
X-OriginalArrivalTime: 09 Mar 2009 15:37:12.0971 (UTC) FILETIME=[EACAEDB0:01C9A0CC]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236613033
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112705>

Thank you very much for your thoughts, especially the specific commands
etc. that I can show the team as reasons.

=== Re: ===
You can tell "git log" to only show one line of history too, but besides
that, micro-details are good. You definitely want to be able to search
the micro-details when things go awry (and they will), so you see
exactly
why some particular algorithm changed later.
=== end ===

Is there a way that someone (for example, product manager) can view only
the main line consisting of topic merges, and not see each one separated
by many many lines of detail changes?  Especially using the GUI?

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
