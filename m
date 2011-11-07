From: Valdis.Kletnieks@vt.edu
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 07 Nov 2011 02:52:17 -0500
Message-ID: <22879.1320652337@turing-police.cc.vt.edu>
References: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com> <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com> <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com> <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com> <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com> <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org> <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com> <20111104145908.GA3903@thunk.org>
            <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1320652337_7081P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: "Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Nov 07 08:52:48 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RNK0b-0005Yo-4J
	for glk-linux-kernel-3@lo.gmane.org; Mon, 07 Nov 2011 08:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab1KGHwi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 7 Nov 2011 02:52:38 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:59618 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1KGHwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2011 02:52:35 -0500
Received: from dagger.cc.vt.edu (dagger.cc.vt.edu [198.82.163.114])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id pA77qMTH009857;
	Mon, 7 Nov 2011 02:52:22 -0500
Received: from auth3.smtp.vt.edu (EHLO auth3.smtp.vt.edu) ([198.82.161.152])
	by dagger.cc.vt.edu (MOS 4.2.2-FCS FastPath queued)
	with ESMTP id SWD86370;
	Mon, 07 Nov 2011 02:52:22 -0500 (EST)
Received: from turing-police.cc.vt.edu (c-71-62-120-57.hsd1.va.comcast.net [71.62.120.57])
	(authenticated bits=0)
	by auth3.smtp.vt.edu (8.13.8/8.13.8) with ESMTP id pA77qHmK001259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Nov 2011 02:52:19 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.3-dev
In-Reply-To: Your message of "Fri, 04 Nov 2011 08:14:52 PDT."
             <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
X-Mirapoint-Received-SPF: 198.82.161.152 auth3.smtp.vt.edu Valdis.Kletnieks@vt.edu 2 pass
X-Junkmail-Status: score=10/50, host=dagger.cc.vt.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A020204.4EB78E36.00AD,ss=1,fgs=0,
	ip=71.62.120.57,
	so=2010-07-22 22:03:31,
	dmn=2009-09-10 00:05:08,
	mode=single engine
X-Junkmail-IWF: false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184956>

--==_Exmh_1320652337_7081P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Nov 2011 08:14:52 PDT, Linus Torvalds said:
> On Fri, Nov 4, 2011 at 7:59 AM, Ted Ts'o <tytso=40mit.edu> wrote:
> > Note that a repository format change will break a bunch of other
> > things as well, including references in commit descriptions (=22This
> > fixes a regression introduced in commit 42DEADBEEF=22)

> No they won't. Not if you do it right. It's easy enough to
> automatically replace the SHA1's in the description, the same way we
> replace everything else.

OK.. I'll bite.  How do you disambiguate a '42deadbeef' in the changelog =
part
of a commit as being a commit ID, as opposed to being an address in a tra=
ceback
or something similar? Yes, I know you only change the ones that actually =
map to
a commit ID, but I'd not be surprised if by now we've got enough commits =
and
stack tracebacks in the git history that we'll birthday-paradox ourselves=
 into
a false-positive in an automatic replacement.

(And it's OK to say =22the 3 stack tracebacks in changelogs we just mangl=
ed can
just go jump=22, but it does need at least a few seconds consideration..)=



--==_Exmh_1320652337_7081P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOt44xcC3lWbTT17ARAqdSAKD8BKeDESG5NM0dZXjFR9OMibTRYgCfZP8A
6Xk6cPcaVy+tbJOahk+ING8=
=/1pP
-----END PGP SIGNATURE-----

--==_Exmh_1320652337_7081P--
