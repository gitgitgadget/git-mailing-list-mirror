From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: use git-daemon by git://IP/path?
Date: Fri, 12 Jun 2009 12:13:08 +0000
Message-ID: <200906121213.13365.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1578321.0nJ74ZItMs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 14:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5dN-0000ik-Cr
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbZFLMNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZFLMNP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:13:15 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:42886 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZFLMNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:13:14 -0400
Received: by fxm12 with SMTP id 12so575157fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=B2MK+VRhkZT+zaSuB+fx9KWPzvjRWcAN0SWTXBJ7u/4=;
        b=DYyLBoKAkhBR5vWxCMRw8RXxGD0b6GNG/T+8DMsONhCU1Kxdr+KRm2NvQuUorGzJoK
         NIjO+/pnRPuE6eUIyltlIn4NQZayC/Utla3YoeJvn3tV9Y/ntYBPj9bTj2j/UACjyZa6
         sEkpRh2NJE65zXp+L4vsXjMSTEammqve7unVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=OxNdsKIpyPb4ppijvY3ezVkQc4KUHe/HrA5fLBTsXq920CTYVrcWn3SUjM18LP2Po+
         8YfX+OHDEVhEQp8dwPOgPs0W9rzHGnBWGx37u7sZDkgjbZyYEhUOkDEZt55EWMRoN/5S
         TDP9zhNE1i1UVrz/U32yDokINiZ/0pQDyccLY=
Received: by 10.103.1.5 with SMTP id d5mr1838981mui.113.1244808795363;
        Fri, 12 Jun 2009 05:13:15 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id n7sm156395mue.28.2009.06.12.05.13.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 05:13:15 -0700 (PDT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121419>

--nextPart1578321.0nJ74ZItMs
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello git users and writers!

I am new to git, but, having read manuals and grasping the concepts of it, =
I=20
would like to first say thanks to all those, who created it!

Things would be fine, but I am having really bad ssh permission problems in=
=20
here: for example, if there is an empty, initialised git archive and it is=
=20
pulled to over ssh, the created files have permissions only u=3DrwX, no mor=
e.=20
Then subsequently git pulling doesn't work. Maybe you know how to solve it?

Also, in general, how can it be set up, that >1 people have a write access =
to=20
the same repository? Only by using the same login?=20

Kind regards,
K=C4=81rlis

--nextPart1578321.0nJ74ZItMs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkoyRlkACgkQHuSu329e3GHF2ACgkWqq3HvTD4+U9AIv9RnBPVGP
IrgAoLrXR1eQ40R7ej/Pb4HWk03Wnpj0
=eehI
-----END PGP SIGNATURE-----

--nextPart1578321.0nJ74ZItMs--
