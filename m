From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Wed, 23 Oct 2013 22:53:14 +0000
Message-ID: <20131023225314.GY865149@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
 <xmqq61sornte.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TqjUw3h+J5USMjbw"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 00:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ7Iq-0006J7-GC
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab3JWWxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 18:53:20 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33261 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248Ab3JWWxU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 18:53:20 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d72:c0a:d498:7594])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 245402807A;
	Wed, 23 Oct 2013 22:53:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq61sornte.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236556>


--TqjUw3h+J5USMjbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2013 at 08:47:57AM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> > Wouldn't a natural fix be to *always* use "Expect: 100-continue" when
> > and only when the probe_rpc() revealed a server supporting
> > GSS-Negotiate authentication?
>=20
> A stupid question. Is GSS-Negotiate the only special case?

I believe so, because it's the only case where we don't have a password.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--TqjUw3h+J5USMjbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSaFNaAAoJEL9TXYEfUvaLo3MP/2dLQYiI+SXKw+OMmkD3ZoFc
bnDMel8wFK0/l/ZvN+zHG/3D1Kjb/GSLtvhp6PSZj3+6yoy6oj4YXTAeWUNfqyhl
tO7IqiC+cL1cRvcn89tKW9xfwQQSGmh7lAIg/I6+2KKyOiwGiljEXBvrZC2JSI66
Dww30L17VSoQLOT5GB8rxfssDyeb3ieP1WSHz1vtLlQVdpNUM9vaAwnpvnBeY6sV
nssUPZVGeVTQLYKPJgME+QoUu6QtsZIFkvbvDgOo0bbsN0jAGNCsp1GNYuPuapr7
dn5HhHQOGUNT5onv+4PTs5O/zynnERhGm11jM3Qsk9ey0le4paNfqwtSEjiuV+SU
9aHr19PxTwwNLiLLP7nLB742MDWJ3UZ2DVq1TXAHjkGCvIMX9dyvdvsv/S4Ie+kK
l3l05It42kWY9CztFXw+OvsKce3TOjAC7fnOQkqJIwfovc4Zedk1a0RzM2MNsbvZ
Ny5R0k/RZEJb3h2YOHME8ddnf4AXd18siPIEI1bd5ag+5tJ5OlKXd22+Y+1ixIMy
8V7N4/RZkA0y7Vg1KpatwBQVbRAhnBXQNWlqFLJRM/Veuu8rG6Ii48uygwr5hz3B
N3uyeIRxwZkwmlpYFfG2uNmyBuuv5N/5QVzjyihy8TC4Ci51mucJgLD6H1qsPTCJ
1yhEfw6EEufRWXpVvLPv
=5SfZ
-----END PGP SIGNATURE-----

--TqjUw3h+J5USMjbw--
