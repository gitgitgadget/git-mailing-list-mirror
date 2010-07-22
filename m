From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: Running git on Windows command line
Date: Thu, 22 Jul 2010 16:02:54 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
 <AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "kusmabite@gmail.com" <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:03:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc1z5-0002mM-8a
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab0GVUDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 16:03:06 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:38775 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab0GVUDE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:03:04 -0400
X-ASG-Debug-ID: 1279828976-34bf93580001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id Y2FBTtH4c6bW1ql1 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Thu, 22 Jul 2010 16:02:56 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Thu, 22 Jul 2010
 16:02:55 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: RE: Running git on Windows command line
Thread-Topic: Running git on Windows command line
Thread-Index: AcspzpgiXh6Hm5INQfiYRrovHSPsmgACUi7Q
In-Reply-To: <AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279828976
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151476>

 

> The msysGit (the development environment for Git for Windows)

> installer does not modify the system-wide path, but the Git for

> Windows installer does. Perhaps you've previously been using msysGit

> instead of Git for Windows?

> 

> --

> Erik "kusma" Faye-Lund



I've only installed "msysgit".  The item in the path, which I assume was added by the option to "Git from command prompt", with the other two choices being "Git bash only" and "git and included unix tools from command prompt".  I did notice that the exact wording, if not the choices meanings (I'm not sure), seemed to change some time within the last two years.



I'm pretty sure Tortoise doesn't set the path, since it asks me where git is to be found.  I've also installed qgit.



But, I suppose that "Git from command prompt" has to work somehow.  I don't see anything for that other than changing the global path to point to these batch file wrappers.



--John












TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
