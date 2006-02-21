From: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Subject: Re: [PATCH] Add new git-rm command with documentation
Date: Tue, 21 Feb 2006 23:36:35 +0100
Message-ID: <43FB95F3.8010504@people.pl>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl> <20060221221446.GA20744@spearce.org> <43FB9455.6010402@people.pl> <20060221223254.GB20744@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig163703FFB7E30692FE5F59AE"
Cc: cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBg7X-0000yz-PP
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWBUWgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBUWgd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:36:33 -0500
Received: from people.pl ([212.85.96.54]:2780 "HELO v00054.home.net.pl")
	by vger.kernel.org with SMTP id S964884AbWBUWgc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:36:32 -0500
Received: from localhost (HELO ?192.168.1.1?) (krzysiek.pawlik.people@home@127.0.0.1)
  by matrix01.home.net.pl with SMTP; Tue, 21 Feb 2006 22:36:27 -0000
User-Agent: Mail/News 1.5 (X11/20060206)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060221223254.GB20744@spearce.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=BC555551
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16567>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig163703FFB7E30692FE5F59AE
Content-Type: multipart/mixed;
 boundary="------------090505090801010207070505"

This is a multi-part message in MIME format.
--------------090505090801010207070505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Shawn Pearce wrote:
> You are leaving -- in $@ for processing later, which means we'll
> try to delete the file '--'.  :-)
>=20
> I think a shift before the break in the -- case would fix this.

Yay! Another stupid mistake from me ;) Thanks again :)

--=20
Krzysiek Pawlik (Nelchael)
RLU #322999 GPG Key ID: 0xBC555551

--------------090505090801010207070505
Content-Type: text/plain;
 name="git-rm.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-rm.patch"

ZGlmZiAtTnJ1IGdpdC0xLjIuMi8uZ2l0aWdub3JlIGdpdC0xLjIuMi5wYXRjaGVkLy5naXRp
Z25vcmUKLS0tIGdpdC0xLjIuMi8uZ2l0aWdub3JlCTIwMDYtMDItMTkgMDE6MTk6MDAuMDAw
MDAwMDAwICswMTAwCisrKyBnaXQtMS4yLjIucGF0Y2hlZC8uZ2l0aWdub3JlCTIwMDYtMDIt
MjEgMjI6NTY6MjMuMDAwMDAwMDAwICswMTAwCkBAIC04NCw2ICs4NCw3IEBACiBnaXQtcmV2
LWxpc3QKIGdpdC1yZXYtcGFyc2UKIGdpdC1yZXZlcnQKK2dpdC1ybQogZ2l0LXNlbmQtZW1h
aWwKIGdpdC1zZW5kLXBhY2sKIGdpdC1zaC1zZXR1cApkaWZmIC1OcnUgZ2l0LTEuMi4yL0Rv
Y3VtZW50YXRpb24vZ2l0LXJtLnR4dCBnaXQtMS4yLjIucGF0Y2hlZC9Eb2N1bWVudGF0aW9u
L2dpdC1ybS50eHQKLS0tIGdpdC0xLjIuMi9Eb2N1bWVudGF0aW9uL2dpdC1ybS50eHQJMTk3
MC0wMS0wMSAwMTowMDowMC4wMDAwMDAwMDAgKzAxMDAKKysrIGdpdC0xLjIuMi5wYXRjaGVk
L0RvY3VtZW50YXRpb24vZ2l0LXJtLnR4dAkyMDA2LTAyLTIxIDIzOjAwOjEzLjAwMDAwMDAw
MCArMDEwMApAQCAtMCwwICsxLDgwIEBACitnaXQtcm0oMSkKKz09PT09PT09PQorCitOQU1F
CistLS0tCitnaXQtcm0gLSBSZW1vdmUgZmlsZXMgZnJvbSB0aGUgaW5kZXguCisKK1NZTk9Q
U0lTCistLS0tLS0tLQorJ2dpdC1ybScgWy1ufC1mXSBbLXZdIDxmaWxlPi4uLgorCitERVND
UklQVElPTgorLS0tLS0tLS0tLS0KK0EgY29udmVuaWVuY2Ugd3JhcHBlciBmb3Igcm0gYW5k
IGdpdC11cGRhdGUtaW5kZXggLS1yZW1vdmUuIEZvciB0aG9zZQorY29taW5nIGZyb20gY3Zz
LCBnaXQtcm0gcHJvdmlkZXMgYW4gb3BlcmF0aW9uIHNpbWlsYXIgdG8gImN2cyBybSAtZiIu
CisKKworT1BUSU9OUworLS0tLS0tLQorPGZpbGU+Li4uOjoKKwlGaWxlcyB0byByZW1vdmUg
ZnJvbSB0aGUgd29ya2luZyB0cmVlIGFuZCB0aGUgaW5kZXguCisKKy1uOjoKKyAgICAgICAg
RG9uJ3QgYWN0dWFsbHkgcmVtb3ZlIHRoZSBmaWxlKHMpLCBqdXN0IHNob3cgaWYgdGhleSBl
eGlzdCBpbgorICAgICAgICB0aGUgaW5kZXguCisKKy1mOjoKKyAgICAgICAgRGVsZXRlIHRo
ZSBmaWxlKHMpIGJlZm9yZSByZW1vdmluZyBpdC4KKworLXY6OgorICAgICAgICBCZSB2ZXJi
b3NlLgorCisKK0RJU0NVU1NJT04KKy0tLS0tLS0tLS0KKworVGhlIGxpc3Qgb2YgPGZpbGU+
IGdpdmVuIHRvIHRoZSBjb21tYW5kIGlzIGZlZCB0byBgZ2l0LWxzLWZpbGVzYAorY29tbWFu
ZCB0byBsaXN0IGZpbGVzIHRoYXQgYXJlIHJlZ2lzdGVyZWQgaW4gdGhlIGluZGV4IGFuZAor
YXJlIG5vdCBpZ25vcmVkL2V4Y2x1ZGVkIGJ5IGAkR0lUX0RJUi9pbmZvL2V4Y2x1ZGVgIGZp
bGUgb3IKK2AuZ2l0aWdub3JlYCBmaWxlIGluIGVhY2ggZGlyZWN0b3J5LiAgVGhpcyBtZWFu
cyB0d28gdGhpbmdzOgorCisuIFlvdSBjYW4gcHV0IHRoZSBuYW1lIG9mIGEgZGlyZWN0b3J5
IG9uIHRoZSBjb21tYW5kIGxpbmUsIGFuZCB0aGUKKyAgY29tbWFuZCB3aWxsIHJlbW92ZSBh
bGwgZmlsZXMgaW4gaXQgYW5kIGl0cyBzdWJkaXJlY3RvcmllcyAodGhlCisgIGRpcmVjdG9y
aWVzIHRoZW1zZWx2ZXMgYXJlIG5vdCByZW1vdmVkKTsKKworLiBHaXZpbmcgdGhlIG5hbWUg
b2YgYSBmaWxlIHRoYXQgaXMgbm90IGluIHRoZSBpbmRleCBkb2VzIG5vdAorICByZW1vdmUg
dGhhdCBmaWxlLgorCisKK0VYQU1QTEVTCistLS0tLS0tLQorZ2l0LXJtIERvY3VtZW50YXRp
b24vXFwqLnR4dDo6CisKKwlSZW1vdmVzIGFsbCBgXCoudHh0YCBmaWxlcyB0aGF0IGFyZSBp
biB0aGUgaW5kZXggdW5kZXIKKwlgRG9jdW1lbnRhdGlvbmAgZGlyZWN0b3J5IGFuZCBpdHMg
c3ViZGlyZWN0b3JpZXMuCisrCitOb3RlIHRoYXQgdGhlIGFzdGVyaXNrIGBcKmAgaXMgcXVv
dGVkIGZyb20gdGhlIHNoZWxsIGluIHRoaXMKK2V4YW1wbGU7IHRoaXMgbGV0cyB0aGUgY29t
bWFuZCBpbmNsdWRlIHRoZSBmaWxlcyBmcm9tCitzdWJkaXJlY3RvcmllcyBvZiBgRG9jdW1l
bnRhdGlvbi9gIGRpcmVjdG9yeS4KKworZ2l0LXJtIGdpdC0qLnNoOjoKKworCVJlbW92ZSBh
bGwgZ2l0LSouc2ggc2NyaXB0cyB0aGF0IGFyZSBpbiB0aGUgaW5kZXguCisJQmVjYXVzZSB0
aGlzIGV4YW1wbGUgbGV0cyB0aGUgc2hlbGwgZXhwYW5kIHRoZSBhc3RlcmlzaworCShpLmUu
IHlvdSBhcmUgbGlzdGluZyB0aGUgZmlsZXMgZXhwbGljaXRseSksIGl0IGRvZXMgbm90CisJ
cmVtb3ZlIGBzdWJkaXIvZ2l0LWZvby5zaGAuCisKKworQXV0aG9yCistLS0tLS0KK1dyaXR0
ZW4gYnkgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQG9zZGwub3JnPgorCitEb2N1bWVudGF0
aW9uCistLS0tLS0tLS0tLS0tLQorRG9jdW1lbnRhdGlvbiBieSBKdW5pbyBDIEhhbWFubyBh
bmQgdGhlIGdpdC1saXN0IDxnaXRAdmdlci5rZXJuZWwub3JnPi4KKworR0lUCistLS0KK1Bh
cnQgb2YgdGhlIGdpdGxpbms6Z2l0WzddIHN1aXRlCisKZGlmZiAtTnJ1IGdpdC0xLjIuMi9N
YWtlZmlsZSBnaXQtMS4yLjIucGF0Y2hlZC9NYWtlZmlsZQotLS0gZ2l0LTEuMi4yL01ha2Vm
aWxlCTIwMDYtMDItMTkgMDE6MTk6MDAuMDAwMDAwMDAwICswMTAwCisrKyBnaXQtMS4yLjIu
cGF0Y2hlZC9NYWtlZmlsZQkyMDA2LTAyLTIxIDIyOjU2OjIzLjAwMDAwMDAwMCArMDEwMApA
QCAtMTA3LDcgKzEwNyw3IEBACiAJZ2l0LW1lcmdlLW9uZS1maWxlLnNoIGdpdC1wYXJzZS1y
ZW1vdGUuc2ggXAogCWdpdC1wcnVuZS5zaCBnaXQtcHVsbC5zaCBnaXQtcHVzaC5zaCBnaXQt
cmViYXNlLnNoIFwKIAlnaXQtcmVwYWNrLnNoIGdpdC1yZXF1ZXN0LXB1bGwuc2ggZ2l0LXJl
c2V0LnNoIFwKLQlnaXQtcmVzb2x2ZS5zaCBnaXQtcmV2ZXJ0LnNoIGdpdC1zaC1zZXR1cC5z
aCBcCisJZ2l0LXJlc29sdmUuc2ggZ2l0LXJldmVydC5zaCBnaXQtcm0uc2ggZ2l0LXNoLXNl
dHVwLnNoIFwKIAlnaXQtdGFnLnNoIGdpdC12ZXJpZnktdGFnLnNoIGdpdC13aGF0Y2hhbmdl
ZC5zaCBcCiAJZ2l0LWFwcGx5bWJveC5zaCBnaXQtYXBwbHlwYXRjaC5zaCBnaXQtYW0uc2gg
XAogCWdpdC1tZXJnZS5zaCBnaXQtbWVyZ2Utc3R1cGlkLnNoIGdpdC1tZXJnZS1vY3RvcHVz
LnNoIFwKZGlmZiAtTnJ1IGdpdC0xLjIuMi9naXQtcm0uc2ggZ2l0LTEuMi4yLnBhdGNoZWQv
Z2l0LXJtLnNoCi0tLSBnaXQtMS4yLjIvZ2l0LXJtLnNoCTE5NzAtMDEtMDEgMDE6MDA6MDAu
MDAwMDAwMDAwICswMTAwCisrKyBnaXQtMS4yLjIucGF0Y2hlZC9naXQtcm0uc2gJMjAwNi0w
Mi0yMSAyMzozNToxMS4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw2NiBAQAorIyEvYmlu
L3NoCisKK1VTQUdFPSc8ZmlsZT4uLi4nCitTVUJESVJFQ1RPUllfT0s9J1llcycKKy4gZ2l0
LXNoLXNldHVwCisKK3Nob3dfb25seT0KK3ZlcmJvc2U9CityZW1vdmVfZmlsZXM9Cit3aGls
ZSA6IDsgZG8KKyAgY2FzZSAiJDEiIGluCisgICAgLW4pCisJc2hvd19vbmx5PXRydWUKKwk7
OworICAgIC12KQorCXZlcmJvc2U9LS12ZXJib3NlCisJOzsKKyAgICAtZikKKwlyZW1vdmVf
ZmlsZXM9dHJ1ZQorCTs7CisgICAgLS0pCisJc2hpZnQKKwlicmVhaworCTs7CisgICAgLSop
CisJdXNhZ2UKKwk7OworICAgICopCisJYnJlYWsKKwk7OworICBlc2FjCisgIHNoaWZ0Citk
b25lCisKKyMgVGhpcyBpcyB0eXBvLXByb29maW5nLiBJZiBzb21lIHBhdGhzIG1hdGNoIGFu
ZCBzb21lIGRvIG5vdCwgd2Ugd2FudAorIyB0byBkbyBub3RoaW5nLgorY2FzZSAiJCMiIGlu
CiswKQk7OworKikKKwlnaXQtbHMtZmlsZXMgLS1lcnJvci11bm1hdGNoIC0tICIkQCIgPi9k
ZXYvbnVsbCB8fCB7CisJCWVjaG8gPiYyICJNYXliZSB5b3UgbWlzc3BlbGxlZCBpdD8iCisJ
CWV4aXQgMQorCX0KKwk7OworZXNhYworCitmaWxlcz0kKAorICAgIGlmIHRlc3QgLWYgIiRH
SVRfRElSL2luZm8vZXhjbHVkZSIgOyB0aGVuCisJZ2l0LWxzLWZpbGVzIFwKKwkgICAgLS1l
eGNsdWRlLWZyb209IiRHSVRfRElSL2luZm8vZXhjbHVkZSIgXAorCSAgICAtLWV4Y2x1ZGUt
cGVyLWRpcmVjdG9yeT0uZ2l0aWdub3JlIC0tICIkQCIKKyAgICBlbHNlCisJZ2l0LWxzLWZp
bGVzIFwKKwktLWV4Y2x1ZGUtcGVyLWRpcmVjdG9yeT0uZ2l0aWdub3JlIC0tICIkQCIKKyAg
ICBmaSB8IHNvcnQgfCB1bmlxCispCisKK2Nhc2UgIiRzaG93X29ubHkiIGluCit0cnVlKQor
CWVjaG8gJGZpbGVzCisJOzsKKyopCisJW1sgIiRyZW1vdmVfZmlsZXMiID0gInRydWUiIF1d
ICYmIHJtIC1mIC0tICRmaWxlcworCWdpdC11cGRhdGUtaW5kZXggLS1yZW1vdmUgJHZlcmJv
c2UgJGZpbGVzCisJOzsKK2VzYWMK
--------------090505090801010207070505--

--------------enig163703FFB7E30692FE5F59AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFD+5Xzgo/w9rxVVVERAossAJ9VDZvEh8NFaE/vDYT9Jho4vhxUzQCeLj2g
NNru8WCFPobxkRoIZ13ahOk=
=qccw
-----END PGP SIGNATURE-----

--------------enig163703FFB7E30692FE5F59AE--
