From: =?UTF-8?Q?Vladimir_'=cf=86-coder/phcoder'_Serbinenko?=
	<phcoder@gmail.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 21:19:19 +0100
Message-ID: <5633D0C7.2020709@gmail.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com>
Reply-To: The development of GNU GRUB <grub-devel@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3067017062602425818=="
To: The development of GNU GRUB <grub-devel@gnu.org>, git@vger.kernel.org,
	savannah-users@gnu.org
X-From: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org Fri Oct 30 21:19:33 2015
Return-path: <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
Envelope-to: gcbgd-grub-devel@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>)
	id 1ZsG96-0004oy-GA
	for gcbgd-grub-devel@m.gmane.org; Fri, 30 Oct 2015 21:19:32 +0100
Received: from localhost ([::1]:52858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>)
	id 1ZsG96-0003lu-0u
	for gcbgd-grub-devel@m.gmane.org; Fri, 30 Oct 2015 16:19:32 -0400
Received: from eggs.gnu.org ([2001:4830:134:3::10]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phcoder@gmail.com>) id 1ZsG8y-0003l4-Q3
	for grub-devel@gnu.org; Fri, 30 Oct 2015 16:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phcoder@gmail.com>) id 1ZsG8x-00059E-QE
	for grub-devel@gnu.org; Fri, 30 Oct 2015 16:19:24 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36306)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phcoder@gmail.com>)
	id 1ZsG8v-00058p-Rq; Fri, 30 Oct 2015 16:19:21 -0400
Received: by wmec75 with SMTP id c75so20574994wme.1;
	Fri, 30 Oct 2015 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-type;
	bh=pccmBLb0NpcByYrYh1wYHFxokoctMkgFPt3YHOwELzs=;
	b=pb7KPBBkpkcKCYnCEHmXY5QQD5KcYdOK4rDO3+bwUN1h3HwXdOj/qqjQLUlIDr5Y0h
	CvgszoUb5BUlzEkE/8WqQJakK1DGFYAOfEfsyVJu4URRRPPa8H0P8JVlFuKokWWWaHc4
	kwVeuIh/IGoA2ADHXK/K75laLrLi/KD6tRrN/DiDRQUWoIELd6IxP5Tqq8DtrPUOe5TC
	cYpSOEw6WA690GN0K50/ouXmAgTYaSYEcFEY01XlYVSGFieWWbimJKf0sxi0UPqzpywv
	kRoZCgTIRildJCIvffBkJeXdLItoNEzwhVxEX7lEdixtFoscfmcUemeFRirBdnoGmMnK
	U4fA==
X-Received: by 10.28.137.210 with SMTP id l201mr80575wmd.103.1446236361257;
	Fri, 30 Oct 2015 13:19:21 -0700 (PDT)
Received: from ?IPv6:2a02:1205:34c8:dc00:863a:4bff:fe50:abc4?
	([2a02:1205:34c8:dc00:863a:4bff:fe50:abc4])
	by smtp.gmail.com with ESMTPSA id
	h198sm4519070wmd.9.2015.10.30.13.19.20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Oct 2015 13:19:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Icedove/38.3.0
In-Reply-To: <5633CE60.8060907@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Error: Malformed IPv6 address
	(bad octet value).
X-Received-From: 2a00:1450:400c:c09::236
X-BeenThere: grub-devel@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: The development of GNU GRUB <grub-devel.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/grub-devel>
List-Post: <mailto:grub-devel@gnu.org>
List-Help: <mailto:grub-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=subscribe>
Errors-To: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
Sender: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280538>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3067017062602425818==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fnFN7DmTfMGQJsWl3wTdQIn2bmMej6k6O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fnFN7DmTfMGQJsWl3wTdQIn2bmMej6k6O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.2015 21:09, Vladimir '=CF=86-coder/phcoder' Serbinenko wrote:
> On 30.10.2015 21:06, Vladimir '=CF=86-coder/phcoder' Serbinenko wrote:
>> On 30.10.2015 15:26, Andrei Borzenkov wrote:
>>> See
>>> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=3D206676601eb853=
fc319df14cd3398fbdfde665ac
>>>
>>>
>>> I was not even aware that this is possible. Is there anything on serv=
er
>>> side that can prevent it?
>>>
>>> Would be good if commit were amended and force pushed to fix it.
>>>
>> It is a bug in SGit. I'll investigate how it happened

I don't have non-fast-forward rights. Does someone from savannah-users
have them? Could he just delete this commit?



--fnFN7DmTfMGQJsWl3wTdQIn2bmMej6k6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREKAAYFAlYz0McACgkQmBXlbbo5nOu3LQD/VXUnb9GJyFRitIqt7ztPdd3X
rvkyFuoyLxcsofcWvckBAKVswKmbMZ+r8ReiglXSlM8WRI4KM1F+zZg6rTUNtkG8
=kreu
-----END PGP SIGNATURE-----

--fnFN7DmTfMGQJsWl3wTdQIn2bmMej6k6O--


--===============3067017062602425818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Grub-devel mailing list
Grub-devel@gnu.org
https://lists.gnu.org/mailman/listinfo/grub-devel

--===============3067017062602425818==--
