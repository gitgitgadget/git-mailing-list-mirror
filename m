From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Question on merge and mergetool settings
Date: Wed, 29 Apr 2009 17:17:07 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70B002E12@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F2FE@EXCHANGE.trad.tradestation.com> <200904292200.11373.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHD1-0003My-0R
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbZD2VSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZD2VSx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:18:53 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:52327 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZD2VSx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 17:18:53 -0400
X-ASG-Debug-ID: 1241039930-679503770004-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id B037A3CB26A; Wed, 29 Apr 2009 17:18:50 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id vknr8NiCW1PnEEt0; Wed, 29 Apr 2009 17:18:50 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Apr 2009 17:17:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: Question on merge and mergetool settings
In-Reply-To: <200904292200.11373.markus.heidelberg@web.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on merge and mergetool settings
Thread-Index: AcnJBWbPflFduBxBTw2QJzC0uI6hUwACj0Iw
X-OriginalArrivalTime: 29 Apr 2009 21:17:50.0329 (UTC) FILETIME=[F3798690:01C9C90F]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1241039930
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117947>

> No.
> 
> There is remote.<name>.url, mergetool.<name>.path
> There is no merge.url, merge.path, mergetool.<name>.url
> 

Can the git-config document be relied on to be complete and up to date?
Any tool can simply claim any variables it likes.  I tried sifting
through the source code, but it's not easy to identify a complete set.

--John



TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
