From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: RE: CRLF behavior
Date: Mon, 26 Jul 2010 11:09:54 -0400
Message-ID: <1A9EA7E081C3FE46A0F446FFB66D10EBA8715C@FL01EXMB01.trad.tradestation.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
 <20100726130857.GA6200@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:26:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPZd-0008Mq-BJ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0GZP0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:26:32 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:54063 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab0GZP0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 11:26:31 -0400
X-Greylist: delayed 982 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 11:26:31 EDT
X-ASG-Debug-ID: 1280156997-34bf4fef0002-QuoKaX
Received: from FL01EXCAHT02.trad.tradestation.com (fl01excaht02.trad.tradestation.com [10.4.0.167]) by mail2.tradestation.com with ESMTP id bE96wlvlM1uDR3Wm (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Mon, 26 Jul 2010 11:10:01 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT02.trad.tradestation.com ([::1]) with mapi; Mon, 26 Jul 2010
 11:09:56 -0400
X-ASG-Orig-Subj: RE: CRLF behavior
Thread-Topic: CRLF behavior
Thread-Index: Acssw7g16fLX26PcQwWLLwDcyp+zYwAEMmZg
In-Reply-To: <20100726130857.GA6200@pvv.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht02.trad.tradestation.com[10.4.0.167]
X-Barracuda-Start-Time: 1280156998
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151846>

Do you mean that's the value it assumes if no entry was found in the file?  That does not match what was happening.



> 

> msysgit has default core.autocrlf=true

> 

> - Finn Arne






















TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
