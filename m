From: "Albert Krawczyk" <u4232169@anu.edu.au>
Subject: Revision Generation Question
Date: Thu, 20 May 2010 17:46:03 +1000
Message-ID: <000d01caf7f0$7f8c6700$7ea53500$@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 20 10:19:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF0yS-0005C3-6X
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab0ETITT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 04:19:19 -0400
Received: from anumail8.anu.edu.au ([130.56.64.134]:37209 "EHLO
	anumail8.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0ETITR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 04:19:17 -0400
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2010 04:19:16 EDT
Received: from mailout2.anu.edu.au (mailout2.anu.edu.au [130.56.64.233])
	by anumail8.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4K7k1Dj025173
	for <git@vger.kernel.org>; Thu, 20 May 2010 17:46:01 +1000 (EST)
Received: from mailout2.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id A30BC9E83A0
	for <git@vger.kernel.org>; Thu, 20 May 2010 17:46:01 +1000 (EST)
Received: from smtphost.anu.edu.au (ds2.anu.edu.au [130.56.64.54])
	by mailout2.anu.edu.au (Postfix) with ESMTP id 5AF979E8040
	for <git@vger.kernel.org>; Thu, 20 May 2010 17:46:01 +1000 (EST)
Received: from AlbertDesktop (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with SMTP id o4K7k1Dp023370
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 20 May 2010 17:46:01 +1000 (EST)
X-Mailer: Microsoft Outlook 14.0
Content-language: en-au
Thread-index: Acr38H9wRbMc/KM7Q1ihRm0XsKTT+w==
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.20.73615 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_300_399 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FORGED_MUA_OUTLOOK 0, FROM_EDU_TLD 0, TO_NO_NAME 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __OUTLOOK_MUA 0, __OUTLOOK_MUA_1 0, __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __USER_AGENT_MS_GENERIC 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147360>

Hi,

I'm trying to figure out how the internal revision generation works. Could
somebody shed some light on how this happens in the code?

I've stepped through the code, however, I still don't really understand how
the revision history gets generated. 

Any pointers will be greatly appreciated :)  

Albert 
