From: Tilman Schmidt <tilman@imap.cc>
Subject: how to create v2 patch
Date: Sat, 01 Dec 2007 13:41:55 +0100
Organization: me - organized??
Message-ID: <47515693.9070405@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC45950784AA21E5427FF6F62"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 13:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyRea-0005Cm-Gl
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 13:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbXLAMkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 07:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXLAMkn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 07:40:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56673 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908AbXLAMkm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 07:40:42 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BF32F4CC6A
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 07:40:41 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 01 Dec 2007 07:40:41 -0500
X-Sasl-enc: Oyar7Sr3c+OLqTQHvictlGhpeXhzQvssPZ345cVRPL19 1196512841
Received: from [192.168.59.127] (pD9E86E37.dip.t-dialin.net [217.232.110.55])
	by mail.messagingengine.com (Postfix) with ESMTP id 3BEAE23B15
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 07:40:41 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.1.4) Gecko/20070509 SeaMonkey/1.1.2 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66713>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC45950784AA21E5427FF6F62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Let's say that following the scheme laid out in
http://www.kernel.org/pub/software/scm/git/docs/everyday.html#Individual%=
20Developer%20(Participant)
I have produced a patch, submitted it to LKML, received a few
comments, committed appropriate changes to my local git tree,
and now want to submit a revised patch. How do I do that?
If I just run git-format-patch again, it produces my original
patch plus a second one containing my updates, but what I need
is a single new patch replacing the first one.

Thanks,
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Yes, I have searched Google!


--------------enigC45950784AA21E5427FF6F62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUVaTMdB4Whm86/kRAgC7AJ9WCkv8ST6pTr+mygFHUF129y1cyACfU6fe
2gP5X8tav8GL+5UE6oWsqsY=
=w874
-----END PGP SIGNATURE-----

--------------enigC45950784AA21E5427FF6F62--
