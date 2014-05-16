From: William Giokas <1007380@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 16 May 2014 06:25:17 -0500
Message-ID: <20140516112517.GB546@wst420>
References: <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
 <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
 <20140516085929.GA546@wst420>
 <5375e6b0f45c_1a1b8d33080@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 13:25:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlGGb-0001Qb-7x
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 13:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbaEPLZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 07:25:29 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53388 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbaEPLZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 07:25:28 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2820323obc.27
        for <git@vger.kernel.org>; Fri, 16 May 2014 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=unDAuay/gjqVlI4goYZiszHwCsfYp0VLs1rAvUS0a+U=;
        b=mQBZs38XLtBxMmugrvhyNB1pcYXjNxV5rDy7nkI/eRH05Xgig5r29Cg/Fg0+g8/keN
         HjPlC7VNFnKoBGnDVNKFH721MGMrWuk/TYK4VtAuEnFv8ExchIMzuFt6Ssan0BUJqM+g
         eMgY/SKCvs5o7F5LwbePBLm41CdXomudUejsddJ1Wy73RaDwhkbysE/jNlWaEhPY7K7I
         q7g5npp945yn/faljrwcADKpgP32yEwhD7txTLV0R/Jdq2vH31GxTI+A+966PMhzGg4R
         v2OYC2GCnV9IRQrVqc85mAcguy6pkfplGWP5biPAjwspVncJI8X1nhNNJ2FUj6WgZood
         Pcdw==
X-Received: by 10.60.155.5 with SMTP id vs5mr16611013oeb.32.1400239528339;
        Fri, 16 May 2014 04:25:28 -0700 (PDT)
Received: from localhost (cpe-173-175-117-154.satx.res.rr.com. [173.175.117.154])
        by mx.google.com with ESMTPSA id fm8sm3876717oeb.10.2014.05.16.04.25.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 04:25:27 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5375e6b0f45c_1a1b8d33080@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249297>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 05:21:36AM -0500, Felipe Contreras wrote:
> How exactly would it be better?
>=20
> If you concede that the Git release wouldn't be affected, then assuming
> a hypothetical future where git-remote-hg is bundled, and we have a
> Mercurial API breakage, we would have:
>=20
>  Git < v2.5 fail, Git >=3D 2.5 get the fix
>=20
> If we unbundle, we have:
>=20
>  git-remote-hg < v0.5 fail, git-remote-hg >=3D v0.5 get the fix
>=20
> What is the big difference?

It's a matter of scope and where the releases happen, that is all.

Thank you,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdfWdAAoJEGkCBthzzQnPvykQANcfMhaPQbff1gJQaH80xUkp
c92guWxkxYJ1x7G29LJeehWAeiYGkibggRkLrTnVQaWkOmE3Y2zwFtHQcBMufU8Y
oyFTqfPEYRLEe13guTw/tFWxgTeiHBqpFuf/rleMxVZWb9Rgopi+pzfXITAVDU5N
t7i36nEjiThLLtG6YXMVp4fFu06cGgaZIp4ywiZRgQRMPphv7+dPag87uBOXIm6z
KefUTsZ5QlI+1hbY2iuEKyKnMce0VvAioCsx43/yqqsZ+Q2lFgYL0H4ey1DNznar
Wwr2Bz4mCLuuj3rdBeNHd6uej56uhNFU/VVUshaumQeK/6kPJDDtdZXJ94Jtv4ps
zjRhLBg6iYWSLr9lcJhLZtPl6UMVvqeXpdjXRt9imhF81QBSEKbJLXAZMyiKr6KB
qan9A9G8OfsbVijsmF+dqcMHXN8WM3OA+m0WSNbnfMrYufbaTMQlYXVrt5WqWazW
nRGegXayoKKwPNEddzUXiUXWzqdOyw+iMBv7ieLmAw9XHPhyn53emAHZpPlusO1/
/w3qOrxRC1YIlZRXIRqd0TGBig4s/W77bN7KFXncOI8SSP2mjmaXLM+XUUj0zQfe
y4DWnS7xyPPy8fv/p5Nan4olM6FTQRrigb4x1/t2XEdiJpYc0spsAcaIhG8O5xDT
ZHHzYbyQqx9z0aRob7ih
=pOh9
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
