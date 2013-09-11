From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Wed, 11 Sep 2013 23:33:17 +0200
Message-ID: <5230E19D.3050802@googlemail.com>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F816A059814A906DACF9B47"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 23:34:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJs3H-0001qi-LO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 23:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab3IKVeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 17:34:05 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:64668 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3IKVeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 17:34:03 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so4930206eek.13
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=WgHuq/R6hL7TmrYZRLjRkXyjOgDjO5sGN9M6FFiH3nQ=;
        b=T/JIRto5bt+tLrpcwssbAaeav4eRK7wDpVOjAeC5nzaPwkHaTlf0AW59JFdGoH03qm
         hYnlmzgsjYJc5qmjCD3FEzrb/DlM7ZIf2+1y4YO9kHfvAjSPGCRZ7j+s1qtcvzT1L72V
         zPyXWI0JWgkTmVrzSfjvwJLE1Rn51Mrjn1FGuWCK2bUzE4dU1boGrGdzJIEQqrPllDoF
         WMusWa5+ku6DIRriCZLBz0ilv6JLl8Em0IvUFj74UqH9ET6LAAhxj+EyQJ1LWiOa5JtB
         viX3Jr7fb6wpqWLpftF8znKBzXI4ZtY7wQkwKkNLV7MF2pjiq08mbRsq9FBs3ELAB6IJ
         Cgdw==
X-Received: by 10.14.184.132 with SMTP id s4mr5427760eem.13.1378935242313;
        Wed, 11 Sep 2013 14:34:02 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id x47sm201361eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 14:34:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234609>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F816A059814A906DACF9B47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/2013 12:53 AM, Junio C Hamano wrote:
> * sb/repack-in-c (2013-08-30) 2 commits
>  - repack: retain the return value of pack-objects
>  - repack: rewrite the shell script in C
>=20
>  Any further reviews?

Just came home from holiday (with no internet ;)
but I'll review my code now that I have quite
a mental distance to that code I wrote earlier.

Stefan


--------------enig8F816A059814A906DACF9B47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMOGlAAoJEJQCPTzLflhqFK0P/iEsJzrPUfs0YD8XSQuZ0WH6
UcXRUhtWG6+LYlO1bHjZcMCtgc34ieixMX5tL8elDl/0/CVWY4yfOBXlHySELhmI
PZ8UMoiHGco78KzBsh0o8FuCuq474LiMHhBgii5+7WCbV0RHkjS+gpnm+WIs9IW0
742uDbR2cMf/Vv1HHurulQHVv8F1hWGwndc5k8Vals7ltMTLgkojgXT+gaCW5iYv
RMJ/HVsopCrYwSCbF3xbwAbOBPBPBUQFv+s205Z8UOw6wRMRyCqcmQQr69e4O0bg
qCm73Vj9ldFLnksJal25Fs6g1FGS6azsqcJBY65+fRf/45nWO4F6uuKnbwCcINUb
1V2L36YPtPTIoLOk74ZCw3rdePAyqHALq0j2yMQnzDf4DVluiLMCHWPoQgBCau4x
1Ph4+q4DsrIZ3XVxWKEkn/NSglLWTpYjK99iEZ6vhIavNuTiHGutFNrmKcIUN25y
ScsBpf1vqF4+2Y5mGybw3KUKAKflCDE2sK688gR5i4mkYDuVeghdqPgmnipmjTst
96i6EFIhgQlHm4+8CQYEU6r95q5okH+M6Sq0ulX8UAhzTkSoSEG7PwBM246jcQR9
BPXdL5guoqLzGi7Zq6hoULzuk164m+lq4MmVcckDtNa2e7BqC8DDCnNtUC8FxR7B
X54ratwF1THYOXhBG9xd
=dWht
-----END PGP SIGNATURE-----

--------------enig8F816A059814A906DACF9B47--
