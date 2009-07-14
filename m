From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 15:58:49 +0000
Message-ID: <200907141558.54044.Karlis.Repsons@gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com> <200907141323.02151.Karlis.Repsons@gmail.com> <81b0412b0907140634g6aeec60fib23d56d83ba09fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3588109.xInqdQac06";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 17:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQkPM-0003Jz-M8
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 17:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbZGNP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbZGNP66
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 11:58:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:25541 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbZGNP65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 11:58:57 -0400
Received: by fg-out-1718.google.com with SMTP id e12so681431fga.17
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=zXgigF7CbVk8bvRjFYYc0g+f0CLQPdKjhvdswNZnHYM=;
        b=dmsfE02JvyIvr0ETOUTxhCTXoPtJ5it+3IE8DMIct8rsMuE+bH7XWMIMDtmex8zFhc
         LvUHREsewlKotBqK0ddYJynOpdOe4KugWx/lFF8JZcEsO0cKdxgawGaGf+sT7Jg1oybm
         qWcRN+3B9wjxicyAUDWiVfRPUBGujvdAjlqe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=LzDHydeZHW8IVgjJn/fq2kzvTrO4l9qe1OwI2yJ7Xc2fjoYngynH2v7J1AKFJ+ohF8
         lXM8juGOlp6IIE4nVcIzmiM9MuBpdCVgkMcVWRE0EMn9x/nYmzy/D0ClNmBy0e9KZaIz
         6CJZgsuFmPx3PwTX4QGr+U8rnjKMz7+GjcLcU=
Received: by 10.86.96.18 with SMTP id t18mr4162939fgb.58.1247587136162;
        Tue, 14 Jul 2009 08:58:56 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id 4sm6387811fgg.7.2009.07.14.08.58.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 08:58:55 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0907140634g6aeec60fib23d56d83ba09fb9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123256>

--nextPart3588109.xInqdQac06
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 July 2009 13:34:37 you wrote:
> On Tue, Jul 14, 2009 at 15:22, K=C4=81rlis Repsons<karlis.repsons@gmail.c=
om>=20
wrote:
> > I am sorry, another thing was of my interest.
> > My unknown is the technical realisation - how can particular repository
> > be made available for easy pulling from it? Right now with IPv4 most
> > normal workstations are not accessible directly, because they are behind
> > routers.
>
> Same as with the rest of all internet services: you either put the thing =
on
> an internet-facing address or poke a hole in your firewall.

With IPv4 yes. I am using gitorious.org already.
But can IPv6 usage provide a way for git users to pull from one another=20
directly?

--nextPart3588109.xInqdQac06
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpcqz4ACgkQHuSu329e3GHWhgCfRxyg4GWLrnaikO/QPW4/qTqr
ZqkAoNJSRLEM8EULOO2pFo2dd/OWivsX
=bxMu
-----END PGP SIGNATURE-----

--nextPart3588109.xInqdQac06--
