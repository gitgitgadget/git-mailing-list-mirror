From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: [RESEND PATCH] french translation of gitk
Date: Thu, 28 Jan 2010 14:23:06 +0100
Message-ID: <20100128142306.61b8169d@eleanor>
References: <20091202112403.52abcd75@eleanor>
	<c558c59b3fe779e8577fe06233d3da5d2711127f.1259795550.git.ni.s@laposte.net>
	<20091229223758.GB12965@vidovic>
	<20100108142218.386bf6a2@eleanor>
	<20100112112122.GD6685@brick.ozlabs.ibm.com>
	<20100112140250.164e084e@eleanor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Guy Brand <gb@unistra.fr>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 14:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaUPw-0005dK-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 14:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab0A1N2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 08:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016Ab0A1N2K
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 08:28:10 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:28207 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab0A1N2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 08:28:09 -0500
Received: by ey-out-2122.google.com with SMTP id d26so188760eyd.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=lT82sohfvWtFdyv1N9gWePAZAiNR1AxifmGv5jH18yw=;
        b=VTeaYARW+s7c5O/KWUGWY2ngpYySCfaHbR0w71nSqdLN3anfDGipiQhgbewRVWORcC
         7e8CfZqGPuULi3TNIATB2GD2Jdqwo9UPSiHNCirKn3tc1hT070ahkkEnZswCA1B87leQ
         hsSsFxBws/sXBCgFzFmIcnkOWd5jAKAWJtuJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=gEbziMCvj3xyD3WaeQvuXMQP3Gu+rHviqqjFURXZxvwHVEQJnRb1i6xog565veNtqX
         Hp0F1YsFqILq1jR1J8kX+4XDPRgBgu+KMEj4U12S2dalVjBWtBuchc0XBGIQ8cXiGz4D
         HBbGPYkegRynCsxWMPnoWZJyYA19xJZ8hmdEI=
Received: by 10.213.109.68 with SMTP id i4mr6420222ebp.43.1264685287665;
        Thu, 28 Jan 2010 05:28:07 -0800 (PST)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 16sm639555ewy.10.2010.01.28.05.28.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 05:28:07 -0800 (PST)
In-Reply-To: <20100112140250.164e084e@eleanor>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138252>

Hi Paul,=20
I would just remind you to apply my last patch. It correct the previous=
 error,
and is hopefully ready for your gitk tree.

Best regards

Emmanuel Trillaud

Le Tue, 12 Jan 2010 14:02:50 +0100,
Emmanuel Trillaud <etrillaud@gmail.com> a =C3=A9crit :

> Hi Paul,=20
>=20
> Le Tue, 12 Jan 2010 22:21:22 +1100,
> Paul Mackerras <paulus@samba.org> a =C3=A9crit :
> >=20
> > I get those errors too.  Could somebody resend a corrected patch,
> > please?
> Here is an updated patch. It apply and compile cleanly on my gitk tre=
e.
>=20
> Thank for taking care of this.
>=20
> Emmanuel Trillaud
