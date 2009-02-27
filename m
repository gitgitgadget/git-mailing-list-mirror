From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: help with reflog
Date: Fri, 27 Feb 2009 12:39:41 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F06E72@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E04E87@EXCHANGE.trad.tradestation.com> <49A79549.1020802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 18:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld6i7-0004xK-TQ
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbZB0Rju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 12:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZB0Rju
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:39:50 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:38144 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbZB0Rjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 12:39:49 -0500
X-ASG-Debug-ID: 1235756383-632a00e70002-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 8B5981CDB35; Fri, 27 Feb 2009 12:39:45 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id p8Nna10B1oUGNYPK; Fri, 27 Feb 2009 12:39:45 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Feb 2009 12:39:43 -0500
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: help with reflog
In-Reply-To: <49A79549.1020802@viscovery.net>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: help with reflog
Thread-Index: AcmYrIJCt4ALlfIvR0umvxI9j7VuXwAU2peQ
X-OriginalArrivalTime: 27 Feb 2009 17:39:43.0408 (UTC) FILETIME=[5FDD1B00:01C99902]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1235756386
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111687>

>> Did you initialize or clone *this*particular*repository* more than 90
days
ago?

Yes.  I've been working on it since August.



>> Are you saying that the .git/config file is empty?

No, that there is nothing related to changing the default of 90 days.

>> What does 'git config core.logallrefupdates' report?

true.

I'm guessing it wasn't on before, and the first time I tried the reflog
command (or whatever I was reading in the manual) it turned it on
automatically.

--John

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
