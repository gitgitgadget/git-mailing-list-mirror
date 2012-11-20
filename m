From: Lisandro =?iso-8859-1?q?Dami=E1n_Nicanor_P=E9rez_Meyer?= 
	<perezmeyer@gmail.com>
Subject: [wishlist] support git flow-like view
Date: Tue, 20 Nov 2012 20:42:52 -0300
Message-ID: <201211202043.00293.perezmeyer@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12778149.ch6qrsplu2";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 00:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaxZJ-0006T4-EV
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 00:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab2KTXtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 18:49:15 -0500
Received: from mail-gh0-f179.google.com ([209.85.160.179]:40906 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2KTXtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 18:49:14 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2012 18:49:14 EST
Received: by mail-gh0-f179.google.com with SMTP id r14so1286743ghr.10
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 15:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LgZ4mpOBYtwd3bhHJNCO2E73rb+3+oq26gT2vYABlXc=;
        b=FGAPfQT47pdUuK1+0KWliKuXTuI9vmg1ozqnde+keAL/OB7Vx32+vSKDFnwSZVjSJO
         UVOEy12wUDMMaJHsZI7oSaFY921Kejn0/MNGUwIz8Mq8aWAdi6qaawJqcA4VZN9oMLuG
         P0Dag3iHMjeMXzzH6vfPAk9bin94KbnmO1lPVD6G2r2bMGW8ykcoYQq/kexkL3MV+ue1
         r0qHFrUhouQRSYl/PwFiDFomJ/XDFN2JQcmC2dAdkzDGdqV5x4+HRXOhhsdEb8RHX6oF
         LXsehv4iIa1Cu9jGxo27FmgBl+7UF0WQEmy0dQgiwmUpa9zRofKa3Auw5ePkmPkQFHUG
         4ShA==
Received: by 10.236.134.49 with SMTP id r37mr17097297yhi.11.1353454985448;
        Tue, 20 Nov 2012 15:43:05 -0800 (PST)
Received: from luna.localnet ([190.97.25.23])
        by mx.google.com with ESMTPS id q22sm12901308anh.18.2012.11.20.15.43.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 15:43:04 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.2.21+edid; KDE/4.8.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210123>

--nextPart12778149.ch6qrsplu2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi! I am not suscribed to the list, so please CC-me.

I think this may have been proposed before, but I could not find anything i=
n=20
the web, so I better try myself :)

The idea would be to gitk to show a "git flow-like"[0] view when it detects=
=20
git flow (or the user ask for it or...)

Basiccaly, you can show the main two branches: master and develop. Of cours=
e,=20
having the possibility to show feature/release/hotfixes branches would be=20
ideal.

Kinds regards, Lisandro.

[0] <http://nvie.com/posts/a-successful-git-branching-model/>


=2D-=20
Esperando confirmaci=F3n de ingredientes necesarios
que ser=E1n expuestos a la radiaci=F3n...
  Manera geek de expresar que se espera la compra
  de carne para un t=EDpico asado argentino.
  Silvio Rikemberg.

Lisandro Dami=E1n Nicanor P=E9rez Meyer
http://perezmeyer.com.ar/
http://perezmeyer.blogspot.com/

--nextPart12778149.ch6qrsplu2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCAAGBQJQrBV9AAoJEKtkX0BihqfQd1IP/A9IZaSj8ol7K338xUcZUkNc
/F+sSFIkR065aTaQ0nEOLTVFRZOBr6yodp5gXyblXxahnZ5oD8mPm0B1FBMiig2U
0qx/OfQeaLWQyakoPDwFGEHlk+EqBZGMhfwpGrcyrhQ7G0QKxREXSKsIVNw+5+D6
4CTusuBX+62i1OHGTcmH4znK0RA4ZuzjUnTENaNC56cDrxr5iext8Ocx8QGc64/y
EtBzPfdnODoUj5NfcH6cmMzV+fFCpT3R0KOqCq/6D2vHihUbmwoMd/9RdyA/12sd
FR7D0GinPFtN1CrpMjrhuqDZEbGnQFx7JfuCAa/8pPb4gF/iln0d7aXmeXejEM1T
fFDwQCHRxfqs72w462Fw72AzcOfOQ/JlldmrOukQAx4DhH5EmFMM/ojZnoXOKGK/
VUVQJ2X12Skpz80EnAOSUPbP0Av895XyKY8LqYqK9rGAYqOFoCOxWDi0KsKvVz5t
znzOsJ6ORi/ABgyheIZA9FyGxgCFjy183Hz/iIOGJwDodwq1mpSuW6W/fsf/CVKN
DrKK4O1NJnh76XIlhepRA1aj4fRzQe56DYsHDhZKxqpLoGM+/SSn7+piL8l75Sfc
QWxMkhYmU7/HplR2Z42FeGb1ZBonno5i3i6NiN1LmO/prfDuM+ZyYCp19m+mayGb
ifs3Z2E3VgfZCMgXHZ0i
=LGTM
-----END PGP SIGNATURE-----

--nextPart12778149.ch6qrsplu2--
