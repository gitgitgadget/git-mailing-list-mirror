From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Auto-repo-repair
Date: Sun, 18 Nov 2012 17:55:56 +0100 (CET)
Message-ID: <66719060-db68-45b4-8453-2fd996f27657@zcs>
References: <CAM9Z-nn1S9JvfcymotOvSis4CoYco0Htn4uoETZn2kCto0z9zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 17:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta8AG-0008Nr-CF
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab2KRQz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 11:55:58 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:36654 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2KRQz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 11:55:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 765226228C0;
	Sun, 18 Nov 2012 17:55:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ooy3UYBOtPB; Sun, 18 Nov 2012 17:55:56 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 12B5E62203A;
	Sun, 18 Nov 2012 17:55:56 +0100 (CET)
In-Reply-To: <CAM9Z-nn1S9JvfcymotOvSis4CoYco0Htn4uoETZn2kCto0z9zw@mail.gmail.com>
X-Originating-IP: [91.43.183.14]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210033>


> How would the broken repository be sure of what it is missing to
> request it from the other side?

fsck will find missing objects.


>=20
> --
> -Drew Northup
> --------------------------------------------------------------
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>=20

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
