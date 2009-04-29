From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Question on merge and mergetool settings
Date: Wed, 29 Apr 2009 12:25:48 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3F2FE@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 18:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzCdX-0006L1-HJ
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 18:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZD2Q1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 12:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbZD2Q1e
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 12:27:34 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:48087 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbZD2Q1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 12:27:33 -0400
X-ASG-Debug-ID: 1241022446-395b012b0008-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP id 4C4FB3C6000
	for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:27:27 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id SXU9a6LCuVRp5DKR for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:27:27 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Apr 2009 12:26:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Question on merge and mergetool settings
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on merge and mergetool settings
Thread-Index: AcnI5yfEEWjOvipUQzOWEXjLf+7mEQ==
X-OriginalArrivalTime: 29 Apr 2009 16:26:21.0294 (UTC) FILETIME=[3B3290E0:01C9C8E7]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1241022447
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117904>

In my config files which I inherited from someone else, there is an
entry for "url" as well as for "path" under [merge] et al.

I can't find that mentioned in the git-config manual.  Is that really
used?

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
