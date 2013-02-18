From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 6/9] user-manual: Use 'git config --global user.*' for
 setup
Date: Mon, 18 Feb 2013 07:12:54 -0500
Message-ID: <20130218121254.GC8388@odin.tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <27886ef1313956bc19ddb9e658c4eb181fab2e46.1361146398.git.wking@tremily.us>
 <7vobficp8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=oJ71EGRlYNjSvfq7
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7PbE-0001gP-Us
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 13:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569Ab3BRMNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 07:13:01 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:35719 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3BRMNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 07:13:00 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIF00HO50LJL610@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 18 Feb 2013 06:12:56 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id C5F36885C31; Mon,
 18 Feb 2013 07:12:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361189574; bh=Nd6SJgkDx0fcurfz24r0dc1i6w8AIQXQhVN+ef3GRGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AR1SLyWAuQht2JIePlAF4PVQgpYRrXBWtfqfWEIITj3P5ADcPpXrGTxnnN8kdAMMW
 6T1fEmVqVRDEuqG4OHjsOkQ2bHpsBsXWlypQmbUl1LMzWeAFoC79eZcKptt7AqXt0O
 V9gKPtC776u3H+xYYtcUOr2yrIC5EnuCA4ijB3Ww=
Content-disposition: inline
In-reply-to: <7vobficp8y.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216478>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2013 at 06:47:09PM -0800, Junio C Hamano wrote:
> > +Which will adds the following to a file named `.gitconfig` in your
>=20
> s/adds/add/;

Oops again :p.  This change is SOB me.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRIhrFAAoJEEUbTsx0l5OM9X4QAIUzG+QKjaDBeWq3edkBMqmC
pX/OA/EKTEnJNvte5iO6kW3SPGPdL6gtVDqAmXEPFqgZ69STTDa9ATyuRO8jEH1G
BNKXA6r3a6eiwpx9wv+wSJn8dLh/3E8be18T5KPC+H+MMOsb+4MioyIJP52yZSTb
hmX5tWoBt2yalQeIv4Soq6GlUPCN0WaXz/Yl9sKAy5NkqopRRT6PmHup0EDTv45j
IucR11NDxhRR6GCXq9MMOZwMkzi2vyN9OoKcgpTAxw5j7c+vfR6THs9jve6fAlts
g1MpJKRJxlMnpCsrVj4LYAM2RkeSO3Ti0GYoatI6jsromiplJ5jkGsjUft9yFjHI
jShYR4vuhvkapvEBFXJQ1TjdcpxZNk+VJnrEd7tKnlFtJoxlD8g4QYRaHtSI3S2d
I54skIvv8ayQs2CxRXvzk5vhf9P6pvgoRrtfsHjG1DTMj10lBanrKitgJZJ5n6CA
bIjilWLlhtio3LEMYygxFbPDbauHtkamJJjDQ6lvoMv47tIo5sTXcue2sOMXxi2k
cc/ZdDta0XQ1Kw6JlEymCz4GhLbpO1NtW6kYRjkQy0O3WBHMBOgOwYuMuCbNjxE3
R0ChATKtn3spLwq/kh97UH5u+ZYXBggNLMg64YR94P8GgRYOuITPxriQiEKPuV4C
dOXL8tCQQHY9IpN/RHqX
=NYk7
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
