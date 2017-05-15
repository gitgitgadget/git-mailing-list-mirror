Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFCF201A7
	for <e@80x24.org>; Mon, 15 May 2017 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756156AbdEOQa4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 12:30:56 -0400
Received: from sunbase.org ([178.79.142.16]:60192 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdEOQaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 12:30:55 -0400
X-Greylist: delayed 2159 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 May 2017 12:30:55 EDT
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1dAIKl-0000B5-Ln
        for git@vger.kernel.org; Mon, 15 May 2017 15:54:55 +0000
Date:   Mon, 15 May 2017 17:54:55 +0200
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Git mailing list <git@vger.kernel.org>
Subject: Git just passed Subversion on openhub.net
Message-ID: <20170515155454.k6bu4psohr674oo7@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y4aofm3bmstfegtm"
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170428-45-01e908 (1.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y4aofm3bmstfegtm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

openhub.net has a comparion of the number of public repositories on the=20
net, based on searching public hosting services on the net. Git just=20
passed Subversion after the number of Git repositories has exploded=20
lately. It seems as lots of new repositories were created after cpython=20
changed to Git in February.

I've been tracking the development on=20
<https://www.openhub.net/repositories/compare> since 2014-08, and all=20
the data since then are availble on

  https://gitlab.com/sunny256/openhub-repositories
and
  https://github.com/sunny256/openhub-repositories

Current status:

 https://gitlab.com/sunny256/openhub-repositories/blob/master/status.txt

SVG graphs are available on

  https://gitlab.com/sunny256/openhub-repositories/tree/master/graph

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 27e0042e-3985-11e7-b3fc-db5caa6d21d3 |-------------+

--y4aofm3bmstfegtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkZz04ACgkQ+wy+6JSlBuX81gCfcTCIe3HEFojRPtJ+/6BzZeCb
5ucAn12idrhq7w5XxIUnXYrRdPUicbnI
=NsZC
-----END PGP SIGNATURE-----

--y4aofm3bmstfegtm--
