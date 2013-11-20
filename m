From: Matthew Cengia <mattcen@gmail.com>
Subject: Re: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 23:33:21 +1100
Message-ID: <20131120123320.GF26413@debian.cengia.id.au>
References: <l6hbgg$oej$1@ger.gmane.org>
 <528C62BE.7060803@viscovery.net>
 <20131120120326.GD26413@debian.cengia.id.au>
 <528CAB40.8030107@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 13:33:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6yM-0001d6-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab3KTMdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:33:31 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53524 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3KTMda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:33:30 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so9969808pbb.28
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hOlIKDTPNQ3gL0YFaKPeMvYPehbm0HTc40YrCIHcQ9g=;
        b=iDouxRV/RoCVdbjUbU/RxiPZXBQIFyf9nQMkZ979yqWYlkiZj/rpsCAzDgDo0DLNZ2
         AYIiLSuEpVNYB0wzX2hv4QeWr4xHkgqvSTc6cV4Zm2DHPWhwoI6IGWMn5ufz1VySLFkE
         Qz+uUKfrQIq3gqxJZtSXR4nqj+WnD1PaLpL5D98cbAesj9PZSnd4Ff52YR182YtVaIVf
         iUJuWg3r/I23990IMX+ob6OFgWEGM9UpwxuoOJSNyGz51Q4+ZcKUf6GAicvDLpz5sARE
         ekr4yK2kMbQENFs7UrrKmL9q+AlLUv70FSsJXYFYWeKQL8hx7Wqwb8HpKZRMT7PeKhlU
         z6Rg==
X-Received: by 10.66.190.101 with SMTP id gp5mr443988pac.23.1384950809059;
        Wed, 20 Nov 2013 04:33:29 -0800 (PST)
Received: from localhost (c110-22-201-130.sunsh4.vic.optusnet.com.au. [110.22.201.130])
        by mx.google.com with ESMTPSA id ye1sm42613869pab.19.2013.11.20.04.33.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 04:33:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528CAB40.8030107@viscovery.net>
X-PGP-Fingerprint: DB91 CFEF 322D C608 385F  563C 2F88 1AC6 4A16 1033
X-PGP-Key: http://cengia.id.au:2080/~mattcen/pubkey.asc
X-Homepage: http://cengia.id.au:2080/~mattcen
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238076>


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-20 13:29, Johannes Sixt wrote:
[...]
> That's strange. I can't tell what is going on. Perhaps you have some
> criss-cross merges in your history that merge-recursive trips over?

That's as good a guess as any, but I suspect tracking it down may
involve needles and haystacks...

>=20
> Sorry, I don't know how to help you further.

No worries, thanks very much for your help so far nonetheless.

--=20
Regards,
Matthew Cengia

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQJ8BAEBCgBmBQJSjKwPXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwMjI1MjY2QUFCMThBOUQwNEMxOUQ0QjY3
QTdFMzdGMzNCMjI3MkU4AAoJEHp+N/M7InLoF1MP/1G3m8V1mKpj0a6BM8E6iD+y
RNHoMu3xYvEhNRPonVcoDh+AcY6xYcvG/21yIuBSrKGWuQPdBwEFf+hz7W+39zrA
wKQjUyeMs149f65zU27ZPVqAK9tS5I5TNaxRMDrpemgCajxtvadoxb4zrb36VxYi
Q5XVFnKsnMvSalbWHH4OLKnnqUfS656bQwzIi5LN0+sQyvUCeD9WDbgmAlPasCD1
3SuRv7n5TckUE7ctwhS4aD59jbDR4x/uzOSL884sXF2/n/aga7uYU+a5QifiRGVK
Y3GW/GTtEQlRA/5k7iP7iTqTKbfRbrsQiA0eY3GlN8jmdFYAhd15YZB/ZCl8NRYv
LmN4KuAXxGxQZAQlxVD3zadzpLtrDL1tNVV8FpRvXaX/++Jn387xfHQB1VZruy77
5/r0+aHXAmVmoJYglASsnECDYyZhMoAkhdJ45CCIUHW4r+cQw5K2I7lpJzVitjPk
NFw/0yo1ub+z4NqZsHfkETyi77huTlZ97yJVg2bO/I2C9RDFj1WWogM490TsjLvs
+lrGtviw2EPwCXjLOxaBJYiRCtK7UoXc9/wVoI9Nx9FfILM+SSs5ecmM8FcKIYZB
d9YviGbz2CiS+L4dYQ3oHdFebxQ+Fdlyo/OiCVBkhmuMtVidIt5A/xNhRJeqNx2Q
VX2SGtW7jSf9DmB4+5Cd
=hGOk
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
