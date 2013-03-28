From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 17:34:53 +0100 (CET)
Message-ID: <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
References: <7v38vfwlxv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Taranowski <tom@baringforge.com>, git <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>,
	Stephen Smith <ishchis2@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:35:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFnP-0007BL-0e
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab3C1Qez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 12:34:55 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:36224 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282Ab3C1Qey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 12:34:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 0259F280B8;
	Thu, 28 Mar 2013 17:34:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bCuoTAPbLeQ; Thu, 28 Mar 2013 17:34:53 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 97BD028006;
	Thu, 28 Mar 2013 17:34:53 +0100 (CET)
In-Reply-To: <7v38vfwlxv.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219424>

>=20
> I am starting to regret that I caved in and started carrying a copy
> of it in contrib/.  It probably is a good idea to drop it from my
> tree and let it mature and eventually flourish outside.
>=20

that's a shame... it solves a real problem, is simple to use, and reall=
y powerfull.=20

but unfortunately, I have sent a patch that solves a serious bug... whi=
ch had already been reported and patched but had received no answer, an=
d nobody replied to it.

Is there anything that can be done to get this rolling, or a way to hav=
e the use-case it covers better handle by git-submodule ?


currently the problem of a git repo in a git repo is very complicated t=
o deal with in a clean way...


Regards

J=C3=A9r=C3=A9my
