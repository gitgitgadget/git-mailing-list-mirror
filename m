From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Using Git with windows
Date: Fri, 6 Mar 2009 14:10:28 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A115E18@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <tariq.hassanen@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LffSl-0004Wd-9g
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 20:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbZCFTKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZCFTKd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 14:10:33 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:43844 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbZCFTKc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 14:10:32 -0500
X-ASG-Debug-ID: 1236366630-795601710000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 9A81B1F2FFF; Fri,  6 Mar 2009 14:10:30 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id ejOCCNTWK9RZfpZX; Fri, 06 Mar 2009 14:10:30 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 14:10:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Using Git with windows
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using Git with windows
Thread-Index: AcmejxE29g5x8KvURVuql6zoaenXuQ==
X-OriginalArrivalTime: 06 Mar 2009 19:10:29.0870 (UTC) FILETIME=[371980E0:01C99E8F]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236366630
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112475>

I can think of two differences:=A0 Line endings have been mentioned alr=
eady.
But, and I was wondering this already anyway, does the Windows git know=
 that the file system is case insensitive but case preserving?=A0 That =
is, does it just ignore the issue, is there logic to cope with that bet=
ter?=A0 If so, that would be missing if you ran it in the Linux VM.=A0 =
(Unless it checks the file system capabilities rather than the OS it is=
 running under)

--John
(please excuse the footer; it is not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ G=
S: TRAD) of three operating subsidiaries, TradeStation Securities, Inc.=
 (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a=
 trading software and subscription company, and TradeStation Europe Lim=
ited, a United Kingdom, FSA-authorized introducing brokerage firm. None=
 of these companies provides trading or investment advice, recommendati=
ons or endorsements of any kind. The information transmitted is intende=
d only for the person or entity to which it is addressed and may contai=
n confidential and/or privileged material. Any review, retransmission, =
dissemination or other use of, or taking of any action in reliance upon=
, this information by persons or entities other than the intended recip=
ient is prohibited. If you received this in error, please contact the s=
ender and delete the material from any computer.
