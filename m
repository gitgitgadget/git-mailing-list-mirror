From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 13:07:04 -0700
Message-ID: <20140501200703.GB6227@odin.tremily.us>
References: <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vgqGEEhIUeLzQgKp"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 22:07:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxGG-0005cD-E4
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaEAUHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:07:08 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:37375
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbaEAUHH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 16:07:07 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id wiBk1n0040vyq2s5Ck76Qr; Thu, 01 May 2014 20:07:06 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id wk741n00h152l3L3Rk751a; Thu, 01 May 2014 20:07:06 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 2975E1173473; Thu,  1 May 2014 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398974824; bh=HjDfJue59Hnpr0bvFXGimAp0W6etH++lHDRXnZu7nJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qZOs6+Mq/a1dOS6lengVGk8n/9tzSErMtz6XH1qoppeeI5Bk2RYSF+1lvIoeUGvtW
	 oLXm5i3o0cczEouaS+V7uPSbRF0TUvYU6Zse97pJlUXRH37B+AhRljZw18R9x5NrL0
	 PblOO371FfOtnHRNw1HbpSrc1Rw+5cGt8UYjX57E=
Content-Disposition: inline
In-Reply-To: <20140501194846.GA6227@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398974826;
	bh=BVZKAUGPId3VwsMSS+42x2Xx/O8DrnQmParn6KokzM8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=QkWL2AFqZHIs0Xte/iqcz8ThQn44+GNFERt5sPZv51eUPIQ7L7FZn4i9tZdS44bJ7
	 FH6vLRBxFZFkzH1M+6ruqIl2qwk+B45el5NGiDyvSYu+oy3510oPituRciY8VV/mlb
	 NgSeaBclTW3gQinzuR+ukr5l9frX3HL9NTWMaY48IqxpXUFw/F/39RQ2y8no62tqrI
	 L2B1L0efgOB/9GLDWraNGtsz+r3/laX2kGNEZdPb3e3XmRZIzWFAf1XuJQ5pu+jNbN
	 U6E2unjq3KMu4NRvV4AXwUyYQIVVSZMw4hUh8CTS6Qxj44efP7wwdIsWiBVGTWEMbW
	 cAIYTDepRMREQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247835>


--vgqGEEhIUeLzQgKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 12:48:46PM -0700, W. Trevor King wrote:
> My interest in all of the proposed git-pull-training-wheel patches is
> that they give users a way to set a finger-breaking configuration that
> makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6').  Then folk=
s who
> compulsively run 'git pull' (e.g. because SVN habits die slowly) can
> set an option that gives them something to think about before going
> ahead and running the pull anyway.

Actually, what do we think about an -i/--interactive flag (with an
associated pull.interactive boolean config to setup global/per-repo
defaults)?  Then after the fetch, you'd get one of the following:

  Merge $count commits from $repository $refspec into $current_branch?
  Rebase $count commits from $current_branch onto $repository $refpec?
  Fast-forward $current_branch by $count commits to $repository $refpec?

and have a chance to bail out if you saw:

  Merge 1003 commits from git://example.net/main.git master into my-feature?

because you forgot which branch you were on.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--vgqGEEhIUeLzQgKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYqllAAoJEKKfehoaNkbt/wMP/RBWKBrsnsDSzmMUSArFFFiR
Ar3w+z1Mr8mLl35eIMblTrXFw+INfcnfkx5Kh6WhwUtyMbvZY3AM29XGy/v28Uz6
ohzYkTBSAPxipn6NaVcGJhuQNUuaKgucBV7j380rhavDekX5clxoniYoqVvxV9oF
G1tVuYDsY5ifBh74a9L/HDXdyhNy0TStBAlp0Iy1MJuYZ7hEKhiWlNXXLb36pQGH
1nYIp/TJTkVdSeOgt1Wq9F6foT1VZ91nVDG+gOdWlW95r2IZG6b+o61GXh7xdGYP
kw8J5PBng4DpasDB6o2z0QqYl6zY/SerTChe3lumsMP/1SPzmi1dDbdEGzjosodG
LdVuhjztKiG6FWqLnvcWZhjYKUdjUdaHFYINnX0GSdhX22IKktKuyRbZBITiWPmb
dZHZO8FHRrBTe5Bn7PDcG9HDwuV6TzvQdyUHwtX8VmCgaem4dwn25H4AmDKLG2kF
vbLr+mqROhg9tPgnHDIXAYCe9g0+gL/jsHpqz7841Uk/EXzuwaS+1QMyTcmmEu51
GYGE766YeyOYomTNKe8JmU/i9U5YKLAdhR5Ali6YWAZyMDSt5rZJfSD5gaZzINBF
T7eQXRkTXmTyElIPOQXWybVKlp9UMsxRFfsuwMSBVa3qdcpz3n9KYAoPZtmMAYbc
e+3FTHYe3IdZasEjD4Gi
=OnmE
-----END PGP SIGNATURE-----

--vgqGEEhIUeLzQgKp--
