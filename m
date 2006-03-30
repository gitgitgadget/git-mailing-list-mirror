From: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Subject: Re: [PATCH] Ability to automaticaly push tags to remote repositories.
Date: Thu, 30 Mar 2006 16:18:42 +0200
Message-ID: <442BE8C2.5000907@people.pl>
References: <442BD562.3030207@people.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E2E16DB9D1202917CEA81BE"
X-From: git-owner@vger.kernel.org Thu Mar 30 16:18:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOxz2-00027t-HN
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 16:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWC3OSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWC3OSj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 09:18:39 -0500
Received: from people.pl ([212.85.96.54]:35282 "HELO v00054.home.net.pl")
	by vger.kernel.org with SMTP id S932223AbWC3OSi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 09:18:38 -0500
Received: from localhost (HELO ?192.168.1.1?) (krzysiek.pawlik.people@home@127.0.0.1)
  by matrix01.home.net.pl with SMTP; Thu, 30 Mar 2006 14:18:34 -0000
User-Agent: Mail/News 1.5 (X11/20060321)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <442BD562.3030207@people.pl>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=BC555551
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18196>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E2E16DB9D1202917CEA81BE
Content-Type: multipart/mixed;
 boundary="------------070603090900010709000801"

This is a multi-part message in MIME format.
--------------070603090900010709000801
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Krzysiek Pawlik wrote:
> Comments, suggestions?

Broken when there are no tags. Attached patch fixes it.

--=20
Krzysiek Pawlik (Nelchael)
RLU #322999 GPG Key ID: 0xBC555551


--------------070603090900010709000801
Content-Type: text/plain;
 name="fix-no-tags.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fix-no-tags.patch"

Rml4IGF1dG8tcHVzaCBvZiB0YWdzIHdoZW4gdGhlcmUgYXJlIG5vIHRhZ3MuCgotLS0KY29t
bWl0IGVmZjY3YmFmZTMzM2MyOGMyMzhmZWI2MTRmMDk4Yjk4NzIxNmZmYjAKdHJlZSA4NzU4
YWU0YTJlYWNlOWM0ZmRmNjRlYzg5YzFmOTgzODcxMDk3YTc0CnBhcmVudCA2ZTU4MWNmNDNj
Y2Y3MjM2ZWE0N2FjNGJhOWI1MWRmOWNkYTNjNjcxCmF1dGhvciBLcnp5c2llayBQYXdsaWsg
PGtwYXdsaWtAc2lsdmVybWVkaWEucGw+IFRodSwgMzAgTWFyIDIwMDYgMTY6MTA6MjYgKzAy
MDAKY29tbWl0dGVyIEtyenlzaWVrIFBhd2xpayA8a3Bhd2xpa0BzaWx2ZXJtZWRpYS5wbD4g
VGh1LCAzMCBNYXIgMjAwNiAxNjoxMDoyNiArMDIwMAoKIGNnLXB1c2ggfCAgICAyICstCiAx
IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9jZy1wdXNoIGIvY2ctcHVzaAppbmRleCA4NjVjYmQ1Li40MDAxNmMxIDEwMDc1
NQotLS0gYS9jZy1wdXNoCisrKyBiL2NnLXB1c2gKQEAgLTYwLDcgKzYwLDcgQEAgaWYgWyAi
JHthdXRvX3B1c2hfdGFnc30iID0gInllcyIgXTsgdGhlbgogCWlmIFsgISAtZCAiJF9naXQv
Y29naXRvLXRhZ3MtcHVzaGVkIiBdOyB0aGVuCiAJCW1rZGlyICIkX2dpdC9jb2dpdG8tdGFn
cy1wdXNoZWQiIHx8IGRpZSAiY2FuJ3QgY3JlYXRlIGNhY2hlIGZvciBwdXNoZWQgdGFncyIK
IAlmaQotCWZvciBpIGluIGBjZy10YWctbHMgfCBhd2sgJ3twcmludCAkMX0nYDsgZG8KKwlm
b3IgaSBpbiBgY2ctdGFnLWxzIDI+IC9kZXYvbnVsbCB8IGF3ayAne3ByaW50ICQxfSdgOyBk
bwogCQlpZiBbICEgLWYgIiRfZ2l0L2NvZ2l0by10YWdzLXB1c2hlZC8ke2l9IiBdOyB0aGVu
CiAJCQllY2hvICJBZGRpbmcgJHtpfSB0byBsaXN0IG9mIHRhZ3MgdG8gcHVzaCIKIAkJCXRh
Z3NbJHsjdGFnc1tAXX1dPSJyZWZzL3RhZ3MvJHtpfSIKCgoMCiEtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tZmxpcC0KCgo=
--------------070603090900010709000801--

--------------enig5E2E16DB9D1202917CEA81BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEK+jCgo/w9rxVVVERAlUUAJ9a0wXfjn4iUrLNtxqDgBcAfacHfQCfYNZf
n6E/WCXxYbvsS1FZVlUxH5Q=
=2mv5
-----END PGP SIGNATURE-----

--------------enig5E2E16DB9D1202917CEA81BE--
