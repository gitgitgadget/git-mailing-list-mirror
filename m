From: martin f krafft <madduck-JX/+c5DPh7vR7s880joybQ@public.gmane.org>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 14:52:06 -0300
Message-ID: <20080812175206.GA9131@lapse.rw.madduck.net>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
	<32541b130808120925y663967ebm38eced6df77ffe4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6989209692078317020=="
To: Avery Pennarun <apenwarr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	git discussion list <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pasky-AlSwsSmVLrQ@public.gmane.org,
	Manoj Srivastava <srivasta-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>,
	vcs distro packaging discussion list
	<vcs-pkg-d
X-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org Tue Aug 12 19:52:27 2008
Return-path: <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
Envelope-to: gcvp-vcs-pkg@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSy2j-0005RK-0E
	for gcvp-vcs-pkg@m.gmane.org; Tue, 12 Aug 2008 19:52:25 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>)
	id 1KSy1n-0000A6-0I
	for gcvp-vcs-pkg@m.gmane.org; Tue, 12 Aug 2008 17:51:27 +0000
Received: from seamus.madduck.net ([213.203.238.82])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck-0owbi4v4jRjYceiJAzDLgeTW4wlIGRCZ@public.gmane.org>) id 1KSy1e-00009Y-1L
	for vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org;
	Tue, 12 Aug 2008 17:51:23 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id A9E29432D76;
	Tue, 12 Aug 2008 19:51:01 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id C264F80B5; Tue, 12 Aug 2008 14:52:06 -0300 (ART)
In-Reply-To: <32541b130808120925y663967ebm38eced6df77ffe4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/8018/Tue Aug 12 10:36:31 2008 on
	seamus.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham
	version=3.2.3
X-BeenThere: vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
List-Help: <mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
Errors-To: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92120>


--===============6989209692078317020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Avery Pennarun <apenwarr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [2008.08.12.1325 -0300]:
> Isn't this what git-rerere is for?  If TopGit doesn't use rerere,
> maybe it would be easy to add...

I'd rather avoid the need to replay conflict resolution and do it in
one place only. It always seemed to me that git-rerere is a solution
to a problem that could have been avoided.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"it is only the modern that ever becomes old-fashioned."=20
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkihzcYACgkQIgvIgzMMSnWENACgnmq4J9WaJh8FvEwVZAlYlwL1
U84Anjt4sy/4yI0moEUKkES3wfswU50Y
=144N
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


--===============6989209692078317020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
vcs-pkg-discuss mailing list
vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss

--===============6989209692078317020==--
