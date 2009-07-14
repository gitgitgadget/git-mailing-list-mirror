From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 19:15:47 +0000
Message-ID: <200907141915.50929.Karlis.Repsons@gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com> <200907141558.54044.Karlis.Repsons@gmail.com> <81b0412b0907141109j697f4705s4cebd27b9694dac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10676599.9WKO4cHTNO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 21:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQnUc-0002IC-Me
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 21:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbZGNTP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 15:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbZGNTP4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 15:15:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:14577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbZGNTPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 15:15:55 -0400
Received: by fg-out-1718.google.com with SMTP id e12so718866fga.17
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=d4yr/zDIF/I53D+h/MVB9YIfIHGwojMD5MUilX3XEkE=;
        b=Ne7m7XFWKTwx70Zn718VcIhEvhhiSeW8fJXOVU4jbCKLwGg7gQHpb0c3xaQ2lovfdx
         JQ5sqQ1+ajJmCro2oWFX3jO6XSxlDB6SsKqc+lynFE5qdsMI6OWg60y55FwWn0OMXbjx
         RMFiA0QxBjekSp3shIP0cWpOOHDwP3q4vWxrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=K93swk1FPfeeViTKcn6ZQuWLjTuQacrNazGbA1P+dPSA7CMFoK7EBhIrQp1/trby1A
         LIJrfLfwyQP0+geXYOYhiS6aSGdOaR7UM+fYBWUFwxYeRYgLMVO+iLm74DvLQn+2Zh/I
         MjXwICW7+zFyKqnS/RdbQCtA/NZ6orgYURRaY=
Received: by 10.86.94.13 with SMTP id r13mr4509915fgb.19.1247598954067;
        Tue, 14 Jul 2009 12:15:54 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id d6sm8916510fga.10.2009.07.14.12.15.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 12:15:53 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0907141109j697f4705s4cebd27b9694dac7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123267>

--nextPart10676599.9WKO4cHTNO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 July 2009 18:09:32 you wrote:
> On Tue, Jul 14, 2009 at 17:58, K=C4=81rlis Repsons<karlis.repsons@gmail.c=
om>=20
wrote:
> > But can IPv6 usage provide a way for git users to pull from one another
> > directly?
>
> Yes. Wanna use that argument for IPv6 promotion?

Oh, you made me curious about if there is anything more, that you could say=
=20
about the topic! :)
Actually, why not? I now recompile things and soon will start testing...

--nextPart10676599.9WKO4cHTNO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpc2WYACgkQHuSu329e3GEb8QCgxYlHdiYHDpRnJ1fWcjLvAI5j
HqsAoJrLxxBiJATNKubg8hqTRn8bjkPG
=wuUQ
-----END PGP SIGNATURE-----

--nextPart10676599.9WKO4cHTNO--
