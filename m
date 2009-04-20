From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Cryptic error messages?
Date: Mon, 20 Apr 2009 16:18:09 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:21:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvzzF-0005wZ-Tx
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbZDTUST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbZDTUST
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:18:19 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:55764 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbZDTUSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 16:18:18 -0400
X-ASG-Debug-ID: 1240258692-596202980002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id A2E17353903
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 16:18:13 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id FVk8WoXS47LAvcni for <git@vger.kernel.org>; Mon, 20 Apr 2009 16:18:13 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Apr 2009 16:18:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: AQR8 ArPJ BCYC BQti EAqK FmHy G8h6 HSz1 Hgb5 H1gQ ISU3 IYMg I+UM Jk7d J3k/ Kd/V;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{981556B4-901F-4652-A90C-35915A9F9FFE};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Mon, 20 Apr 2009 20:18:09 GMT;QwByAHkAcAB0AGkAYwAgAGUAcgByAG8AcgAgAG0AZQBzAHMAYQBnAGUAcwA/AA==
Content-class: urn:content-classes:message
x-cr-puzzleid: {981556B4-901F-4652-A90C-35915A9F9FFE}
X-ASG-Orig-Subj: Cryptic error messages?
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cryptic error messages?
Thread-Index: AcnB9R+dppVwhemNQEyzcb37W8AVNQ==
X-OriginalArrivalTime: 20 Apr 2009 20:18:13.0122 (UTC) FILETIME=[21934E20:01C9C1F5]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240258693
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117029>

$ git push
Counting objects: 9, done.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 3.62 KiB, done.
Total 8 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (8/8), done.
fatal: unresolved deltas left after unpacking
error: unpack failed: unpacker exited with error code
To //tx01fs01/sys/dev/git/repositories/aardvark.git
 ! [remote rejected] dev -> dev (n/a (unpacker error))
error: failed to push some refs to
'//tx01fs01/sys/dev/git/repositories/aardvark
.git'



Huh?  I'm having trouble defending git's reputation.

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
