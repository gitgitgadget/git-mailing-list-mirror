From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: How is git used as other than the project's version control?
Date: Mon, 27 Apr 2009 19:10:06 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70AE3EC4B@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com> <18071eea0904271606t4757a01di40e7b0cf6c558bea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZyh-0005K7-Ok
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbZD0XK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZD0XK7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:10:59 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:39587 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbZD0XK6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:10:58 -0400
X-ASG-Debug-ID: 1240873857-029303620000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id 8793C3A433C; Mon, 27 Apr 2009 19:10:57 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id ccUB0yvvVPsYS2Oh; Mon, 27 Apr 2009 19:10:57 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 19:10:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: How is git used as other than the project's version control?
In-Reply-To: <18071eea0904271606t4757a01di40e7b0cf6c558bea@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How is git used as other than the project's version control?
Thread-Index: AcnHjMp9ibRU896xS6yB4moMKinSsAAABKFg
X-OriginalArrivalTime: 27 Apr 2009 23:10:07.0799 (UTC) FILETIME=[4E7E5C70:01C9C78D]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240873857
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117731>

> What is it you're really asking here?  

When putting together a presentation on git, I created a simple-looking
slide claiming that "developers will use git anyway" as a
general-purpose tool.  I find lots of web chatter about using it as a
lighter-weight front-end to an Enterprise VCS, or as part of a technique
for working away from your desk in such a system.  But it got me
thinking about how it might be more like a text editor in the sense if
being more generally useful than just that specific thing it's "for".
But I don't have any concrete examples, just a vague notion.


> I use "git diff" all the time
> outside of $GIT_DIR for instance -- invaluable, and was designed
> deliberately that way.
> 
> -- Thomas Adam






== beware, monster footer ahead==

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
