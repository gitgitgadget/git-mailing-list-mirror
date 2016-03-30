From: Thomas Marr <a.soobiah@outremer-telecom.fr>
Subject: Message.
Date: Wed, 30 Mar 2016 02:50:51 +0000 (UTC)
Message-ID: <391548419.3956474.1459306251165.JavaMail.zimbra@outremer-telecom.fr>
References: <357637774.3932650.1459300252372.JavaMail.zimbra@outremer-telecom.fr>
Reply-To: Thomas Marr <thomasmarr64@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Mar 30 05:12:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al6YQ-0001nZ-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 05:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbcC3DMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 23:12:18 -0400
Received: from batty.resot.net ([109.62.64.6]:28344 "EHLO batty.resot.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbcC3DMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 23:12:17 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Mar 2016 23:12:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=outremer-telecom.fr; i=@outremer-telecom.fr;
  q=dns/txt; s=d8061456-f9146; t=1459307537;
  x=1490843537;
  h=date:from:reply-to:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=UqhU9J7isWy0ZQDMORWlQDkcI8HLPmrxaBzRChtxYBo=;
  b=Udv2G5n0ewt2RL2583UeqTTnx3JP5YGTrEvGhi+XG2n1ev9d5beTpgyv
   rR42A0DHWUcv9Cnfca6QA87ZFc0PnGasB9FcKUfFY9R0bKuotKy0H2kMQ
   0uzmp9zm+x0fMkxH+oXcDs3OIuNvH9rHyMnjHAdnQoIPsNPN4Dj6s9B2H
   3zCoiuFoD2ykK/4kf/90ObxtLC1FzZoY13qa15o/btBj2dUPxx1OLMnYj
   B3ubTbZk4nrC5WkMW7JXiW2WTDg/abW4yJH8mAvAXDoi9WftTunmEdcRY
   GdlFSxxbNlD8ImjbwlXDG80mXKRHhPlptHOTPm6/BLRpbmgWJYH3OtOTX
   w==;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2EEwQD0QPtW/woGEKxHFg+EaBKmbQEBAQEBAQZmBIJ/iHGCXSeGIIIKhAMCKIFVEAEBAQEBAQEDgQhBEgGDZQkBAQQLGAhGGAIBEBICDQIXAgIvAQ4BCQ8CB4YCgiABAbAKgW6EM4UyBAqFGQELAR18hFmCQ4ZON4MBEIJGBY1EhUqEXo5UgQMBh2aBMQtNg02CPIwHSgI3g1oCNIYygXt+AQEF
X-IPAS-Result: A2EEwQD0QPtW/woGEKxHFg+EaBKmbQEBAQEBAQZmBIJ/iHGCXSeGIIIKhAMCKIFVEAEBAQEBAQEDgQhBEgGDZQkBAQQLGAhGGAIBEBICDQIXAgIvAQ4BCQ8CB4YCgiABAbAKgW6EM4UyBAqFGQELAR18hFmCQ4ZON4MBEIJGBY1EhUqEXo5UgQMBh2aBMQtNg02CPIwHSgI3g1oCNIYygXt+AQEF
Received: from mau-zimbra-01.mail.omt.local ([172.16.6.10])
  by TH2-ironport-01.intranet.local with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Mar 2016 03:01:47 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mau-zimbra-01.mail.omt.local (Postfix) with ESMTP id 661B025A514C;
	Wed, 30 Mar 2016 02:50:55 +0000 (UTC)
Received: from mau-zimbra-01.mail.omt.local ([127.0.0.1])
	by localhost (mau-zimbra-01.mail.omt.local [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YB8Rj46_gogU; Wed, 30 Mar 2016 02:50:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mau-zimbra-01.mail.omt.local (Postfix) with ESMTP id 98FB625A5FD7;
	Wed, 30 Mar 2016 02:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mau-zimbra-01.mail.omt.local
Received: from mau-zimbra-01.mail.omt.local ([127.0.0.1])
	by localhost (mau-zimbra-01.mail.omt.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WERVwsVTBz-w; Wed, 30 Mar 2016 02:50:52 +0000 (UTC)
Received: from mau-zimbra-01.mail.omt.local (localhost.localdomain [127.0.0.1])
	by mau-zimbra-01.mail.omt.local (Postfix) with ESMTP id 303BB25A39A2;
	Wed, 30 Mar 2016 02:50:51 +0000 (UTC)
In-Reply-To: <357637774.3932650.1459300252372.JavaMail.zimbra@outremer-telecom.fr>
X-Originating-IP: [172.16.75.246]
X-Mailer: Zimbra 8.6.0_GA_1169 (zclient/8.6.0_GA_1169)
Thread-Topic: Message.
Thread-Index: s2DeHt3RZ9ZB5W8qQKG0WJgD4DfFXTlQBwSZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290265>

My Name is Thomas Marr and currently work as a Branch Operations Manage=
r at Lichfield Finance Trust Bank, I wish to propose/discuss a profitab=
le business opportunity to the tune of =C2=A35,732,000.00GBP with you, =
do indicate your willingness to partner with me for more information. R=
egards, Thomas Marr.
