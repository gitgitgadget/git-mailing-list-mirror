From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: proper way to merge?
Date: Tue, 3 Mar 2009 11:04:03 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F075F9@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com> <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E709F07452@EXCHANGE.trad.tradestation.com> <49ACDD17.2060601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Bryan Donlan" <bdonlan@gmail.com>, <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeX7v-0003q9-Vs
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbZCCQEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbZCCQEK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:04:10 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:56474 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbZCCQEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:04:08 -0500
X-ASG-Debug-ID: 1236096244-29a7019b0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id B91EE1E166B; Tue,  3 Mar 2009 11:04:04 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id cr7Veg5j24ghxq6c; Tue, 03 Mar 2009 11:04:04 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 11:04:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: proper way to merge?
In-Reply-To: <49ACDD17.2060601@viscovery.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: proper way to merge?
Thread-Index: Acmb0kAITDrd2Md4QLK2au+5Gz6++AARjTfg
X-OriginalArrivalTime: 03 Mar 2009 16:04:04.0309 (UTC) FILETIME=[ACBF1850:01C99C19]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236096244
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112099>

===Re:===
Huh? filter-branch *is* in msysgit. Why do you think it is not?
===end===

Because when I tried it I got " git: 'filter-branch' is not a
git-command. See 'git --help'."
Then I looked in the Git installation directory and did not find any
file with that name.  Then I looked at the ReleaseNotes.rtf file in the
top of the Git installation tree and saw, 
" *	Some commands are not yet supported on Windows and excluded from
the installation; namely: git archimport, git cvsexportcommit, git
cvsimport, git cvsserver, git filter-branch, git instaweb, git
send-email, git shell, git svn."


So I wonder why you think it *is* in msysgit?  This is the latest
version from their site.

--John
(please excuse the footer; it's not my idea)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
