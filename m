From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 20:52:24 +1000
Message-ID: <20110602105223.GB4709@Imperial-SSD-Overlord>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
 <20110602103833.GA4709@Imperial-SSD-Overlord>
 <BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5W0-0001ta-K2
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933471Ab1FBKwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 06:52:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62492 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459Ab1FBKwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 06:52:31 -0400
Received: by pwi15 with SMTP id 15so446333pwi.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UnH76/Qi9jvaz9Hnas7/RJiNAEXDYnKSmv4J+p/FiJo=;
        b=LK2DEy7UN6aFoAume7aq93+WKCzPCQ7Q4khUahHD8XbRi8RYfknXjPtss47skvKCpT
         CkbQiVZyh98Dl7IIB8B2DcfR+gacQWL2LH9aw7FoGT870dSm5f1gji8hoi6v4/aSlrDg
         MKzz/B7q1+70hj2FUnT/qGwC3bMZU3GD9dxIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u3wK7Aqwp82fCVrRN85ym/S5T+UHsgrH9ihpVNM5wD9kbKVJhrZKXIqCkv4k4CrVOl
         L+Ghc3f51DPviaJln1xsKcyZ+5J0jnZC2CqbWPBvrBz+Q/OZpb08mgWdp1fVXUftUK1C
         iEwvuHScsa0MDbfvLe2iNcTuApyMPFbJ3izxI=
Received: by 10.68.8.131 with SMTP id r3mr8914pba.299.1307011949436;
        Thu, 02 Jun 2011 03:52:29 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id k9sm490124pbc.38.2011.06.02.03.52.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 03:52:28 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QS5Vo-0002qY-UC; Thu, 02 Jun 2011 20:52:24 +1000
Content-Disposition: inline
In-Reply-To: <BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174940>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 11:43:19AM +0100, Howard Miller wrote:
> Hi Tim,
>=20
> Thanks for the lengthy post :) As I said in my previous post, I
> think/hope I have resolved it. I did read the manpage first (I'm not
> so brave not to before posting here!!) and it did what it said it
> would. I just misinterpreted it. A final merge was required. I
> actually picked that up from the "Pro Git" book page which mentions
> that extra step.

Well, I'm confused, but that'll be due to my ignorance.

As long as you're sorted out.


As for the manpage, though, as someone who read and misunderstood it, do
you have any suggestions for its improvements?


Tim

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN52tnAAoJEGNoa2q+dzQWZVoQAKKrvisTd8YVpuJs6B8MOn6V
AJDOZ0FHkm7pAmuCUrS9w295O7ySBAr3lGBYiC/LRdFvja34eu3bGtshF94dq1b0
O9oI9xu66Vp8gRm59xQRnuTEeJJ+vC/z3WG52fXxTyaAPxkoE0eJmOVWnwAdLaFW
rYsHU5H63zDibZzvxc8KJtY+5Emy9vIz0qP7WhqqJhDOAqeliRAD9to5OkmOex0R
NnGjaVShhA6EIOsM5CgUJC2HmU+FDHJRMiQqrnLQEDSwJ1PiiHnw7ambq4//+Ti+
8+wBtMONFznL102/2GYrYllaF6yaQFYUUsPEMuDbZMpgsyKZgAS1ZOflGUneglm6
XT2wZlQXS2Xx8zL+1kpJe/dPE7HtZ8C4MfZZEDaT7CtnGGvUr47WJopmfk3+ZrXW
RLIh3O0crvQW/JBGpSBTDcZgBeT3QIiAAVbYtPF4qQ8kT6zc9ilAf2OQHzYtWW2Q
YpaDdVXrpMoKGkInmNP3/Yi4zdZARPGhgZp0K9c9F4conlJnmXKaeDRSl+WN2von
5z4a1NJY+KTOug4689NWrq2/0xN/lgVy1AbJy3hlZeTzaCka4+/bVl1ZtQehnytN
U8PPVnjHVWkgVmXONQc8ee5Hk2ieRWe+3IHz2lCCxqvKTlktmtvsJ5TSvLUxaSLN
wqQwjfi6m+ihESUTiRXX
=2X0t
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
