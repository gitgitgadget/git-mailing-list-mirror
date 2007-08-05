From: pavlix <pavlix@pavlix.net>
Subject: GIT push to sftp (feature request)
Date: Sun, 5 Aug 2007 11:05:40 +0200
Message-ID: <200708051105.44376.pavlix@pavlix.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1671481.l3AtBR2RRg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 11:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcd7-00064D-1C
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbXHEJma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbXHEJma
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:42:30 -0400
Received: from 136.155.broadband6.iol.cz ([88.101.155.136]:4450 "EHLO
	tentacle.pavlix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbXHEJm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:42:29 -0400
X-Greylist: delayed 2117 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2007 05:42:29 EDT
Received: from [2002:5865:9b88:1:214:85ff:fe34:c583] (unknown [IPv6:2002:5865:9b88:1:214:85ff:fe34:c583])
	by tentacle.pavlix.net (Postfix) with ESMTP id 4351F10581
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 11:07:12 +0200 (CEST)
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54975>

--nextPart1671481.l3AtBR2RRg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello

It would be very useful if git supported sftp urls to push to remote=20
repositories.

The use cases are obvious... you would only need ssh run on the other side,=
=20
which is usually available. One cannot or doesn't want to install git on=20
every machine where he wants his remote repository.

Git would also have to be able to create a remote repository (maybe an opti=
on=20
to push?).

Did I miss something?

Pavel =C5=A0imerda

P.S.: I am switching from bazaar-ng which can save so sftp and other protoc=
ols

=2D-=20

Web: http://www.pavlix.net/
Jabber & E-mail: pavlix@pavlix.net


--nextPart1671481.l3AtBR2RRg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGtZLkCpyEseY5FAARAufYAJ9NOgd+Eb5+KrlAJIYPP8FeL6EjgQCfdW6F
aFJb/MhN3ETK5aJYoFZOFvQ=
=4x3Q
-----END PGP SIGNATURE-----

--nextPart1671481.l3AtBR2RRg--
