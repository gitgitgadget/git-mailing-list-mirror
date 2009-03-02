From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: remote branches, and branch names in general
Date: Mon, 2 Mar 2009 15:46:39 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:48:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeF3f-0004kw-PQ
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 21:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbZCBUqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 15:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZCBUqr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 15:46:47 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:33327 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZCBUqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 15:46:46 -0500
X-ASG-Debug-ID: 1236026803-29b000ca0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP id 945771DA2F8
	for <git@vger.kernel.org>; Mon,  2 Mar 2009 15:46:43 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id vrfygA7Fwso7NO4A for <git@vger.kernel.org>; Mon, 02 Mar 2009 15:46:43 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 15:46:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: 9jQ= AfL0 ByQD B3rl B6e8 CVnX DVId EEZ9 EoGU FFQz FRhd FbUL HGme Huu6 IUKF JII7;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{64DCFC14-8FAE-4EEE-9C49-A8FC98DB394E};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Mon, 02 Mar 2009 20:46:39 GMT;cgBlAG0AbwB0AGUAIABiAHIAYQBuAGMAaABlAHMALAAgAGEAbgBkACAAYgByAGEAbgBjAGgAIABuAGEAbQBlAHMAIABpAG4AIABnAGUAbgBlAHIAYQBsAA==
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: remote branches, and branch names in general
x-cr-puzzleid: {64DCFC14-8FAE-4EEE-9C49-A8FC98DB394E}
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: remote branches, and branch names in general
Thread-Index: Acmbd/xqs4+R1bMMQCalXkts/1063A==
X-OriginalArrivalTime: 02 Mar 2009 20:46:42.0919 (UTC) FILETIME=[FE73DF70:01C99B77]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236026803
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111963>

I see the remote branches with names of the form remotes/pub/name where
pub is the nickname of the place I pull from.  To specify such branches,
must I always spell it out with the leading "remotes/", or can that be
shorted or implied somehow?  

Meanwhile, I see that branch names can be hierarchical, as I found out
when I accidently created a branch called "pub/xxx".  So I'm wondering
about the usefulness of using that for organizing topic branches based
on assigned tasks organization and the person owning that branch.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
