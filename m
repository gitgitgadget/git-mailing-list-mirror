From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Wed, 08 Apr 2015 00:15:56 +0200
Message-ID: <5524571C.90007@posteo.de>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>	<1428110521-31028-2-git-send-email-koosha@posteo.de> <xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xXoFugWCkfkjoxRi5TMu4UiguXO8ED7CI"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfbnk-0004Su-H0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 00:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbbDGWQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 18:16:52 -0400
Received: from mx02.posteo.de ([89.146.194.165]:36778 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbbDGWQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 18:16:51 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 4454225A2129;
	Wed,  8 Apr 2015 00:16:50 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lM34K5cPrz5vN5;
	Wed,  8 Apr 2015 00:16:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266943>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXoFugWCkfkjoxRi5TMu4UiguXO8ED7CI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/04/2015 10:00 PM, Junio C Hamano wrote:
> Koosha Khajehmoogahi <koosha@posteo.de> writes:
>=20
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> [kk: wrote commit message]
>=20
> Ehh, what exactly did you write ;-)?
>=20
> I think the most important thing that needs to be explained by the
> log message for this change is that the variable is honored only by
> log and it needs to explain why other Porcelain commands in the same
> "log" family, like "whatchanged", should ignore the variable.
>
So, what would be the reason?=20
=20
> I think that we must not to allow format-patch and show to be
> affected by this variable, because it is silly if log.merges=3Donly
> broke format-patch output or made "git show" silent.  But I didn't
> think about others.  Whoever is doing this change needs to explain
> in the log message the reason why it was decided that only "git log"
> should pay attention to it.
>=20



--xXoFugWCkfkjoxRi5TMu4UiguXO8ED7CI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVJFccAAoJEOD/TftIQWBVzZsP/2SajpmTJZK2HrioH3eE6I75
CHUIfh2rkQNTWfYSxwhheJPoiKBOV+2z4S2IBN8N+cJNxcyOo1C7huN4QsiUI+/U
DOFY3+kCo6pQI1i5rBuLdwB2Mc9eZ36WfYqk3YDzpU2CGBAX3J2txYaaB3U3qu6h
ZsPFhf8Ht4T1LPlXPja/lC1W/mWFzEG6WoxfJsjnNeQdmfSzYAhxAjuIILz6i9LO
xSViKVjIIc2iRjh8hiBW6Oqjv2vrtZevPDarzngZGAk1pQfLGqjDZKX5bc2Uc1Ve
8CYzXfr7o/bifJ/Qmz3SCgrmoxPytBeh/d9JCddYPcnpo6KFbJ2U7dpWwz9lMs2T
bdvtVQqHjaUW8UOGkWlgHo+zwWkiDLqeMkquaduPp4r9urzzYbsXXbB2qIqXRl9s
JIjTHH3h+v+JqNTWjsfFQLN/kMfx4oUouZNCVk5I/nXlU0sJ9lAKTS4ow/5Pytw4
PX/2PzHxTTlgN3VpQNcmGGU9JwHmiaNpRfo5AM6LhixniprDOGqJODrSjnotbdJg
cxZLnCsarVsarx7VLmT3VCmYmQE0un7JTYJJd1btGpjTUKbBSM7y0LxuysW4NlT6
nzJloQXBK1Wkhh1x/m0UfxNqB5pQ2BLdI8rfnQ/Di9Pu97+jPdeWR7wBYBlsWL7p
Iwnro/1voRGnIUG5tx0L
=gw/y
-----END PGP SIGNATURE-----

--xXoFugWCkfkjoxRi5TMu4UiguXO8ED7CI--
