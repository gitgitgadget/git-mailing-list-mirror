From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: Running git on Windows command line
Date: Thu, 22 Jul 2010 16:55:50 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EB939DAC@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
	<AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
 <AANLkTin-RMEOfc7FlfnQfTgzxMfV-Vq6r5ahkP6P6_SJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "kusmabite@gmail.com" <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:56:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2oJ-0004Mn-VX
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab0GVU4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 16:56:01 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:39752 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0GVU4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:56:00 -0400
X-ASG-Debug-ID: 1279832151-34bf9dc30001-QuoKaX
Received: from FL01EXCAHT01.trad.tradestation.com (fl01excaht01.trad.tradestation.com [10.4.0.166]) by mail2.tradestation.com with ESMTP id 2jq9lj1YAqPeMk4M (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Thu, 22 Jul 2010 16:55:51 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT01.trad.tradestation.com ([::1]) with mapi; Thu, 22 Jul 2010
 16:55:51 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: RE: Running git on Windows command line
Thread-Topic: Running git on Windows command line
Thread-Index: Acsp3kFDtpuLzHJ3QQGI5LxV03H3jgAAKdiQ
In-Reply-To: <AANLkTin-RMEOfc7FlfnQfTgzxMfV-Vq6r5ahkP6P6_SJ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht01.trad.tradestation.com[10.4.0.166]
X-Barracuda-Start-Time: 1279832151
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151483>

> It sounds to me like you've installed indeed Git for Windows (which is

> the end-user product from the msysGit-project); the msysGit installers

> doesn't show a wizard with questions, it just installs a

> self-contained development environment.

> 

> You can tell the packages apart by the name:

> * Git-something.exe and PortableGit-something.exe are installers for

> Git for Windows.

> * msysGit-netinstall-something.exe and

> msysGit-fullinstall-something.exe are installers for msysGit, the

> development environment used to develop Git for Windows.

> 

> I hope this clears up a bit.

> 

> --

> Erik "kusma" Faye-Lund



OK, "Git-1.7.0.2-preview20100309.exe" installed something that identifies itself as "git version 1.7.0.2.msysgit.0" 



The web page is identified as "msysgit" with "git for windows" in small type under it, which I take to be a descriptive statement, not a product name also.  The downloads call them "Full installer for official Git" (what I used) and "...if you want to hack on Git".



The usage on this mailing list has always been "msysgit" as this windows variant git, as opposed to the Cygwin build.  Mentioning that is necessary for accurate help.  I mentioned msysgit as the keyword necessary when asking for help, not to mean I installed the development source.



--John











(ridiculous and unnecessary footer follows)


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
