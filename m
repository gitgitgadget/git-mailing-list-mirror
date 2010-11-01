From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Add support in sample hook script for denying annotated tags.
Date: Mon, 1 Nov 2010 02:29:37 -0500
Message-ID: <201011010229.45218.bss@iguanasuicide.net>
References: <201010311457.17817.bss@iguanasuicide.net> <20101031202433.GB21240@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2785043.hmix7RS3Av";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 08:30:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCoqg-0006fA-Iz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 08:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0KAHaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 03:30:15 -0400
Received: from rei.iguanasuicide.net ([209.20.91.252]:49431 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab0KAHaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 03:30:13 -0400
Received: from 76-220-103-20.lightspeed.fyvlar.sbcglobal.net ([76.220.103.20] helo=monster.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1PCoq7-0002sI-2q; Mon, 01 Nov 2010 07:30:04 +0000
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20101031202433.GB21240@burratino>
X-Face: ^vamSukCH~ctN{VF@Q-&WG{+0';38cJ]\/:{x0w-b'+GPuWvNg%NAa2SuBw=&"obQ@q;2h
	6&5@)xd86p;wyaJ%f7&z_BW}Dkm.L$-#h%DUdk7thS-HC_A^Jp|#Tq4R/^q/-]wRVU^T?j
	g@-H./`NrG[
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUSKVkSKVkSKVkSKVkrXb
	grXbgrXbgrXbhEddVEddXI2uzI2uxEddUrXbgSKVlvm9zseJLgAAAAC3RSTlMZS96SGZLeS95LGbtQ3
	6QAAAI0SURBVDjLbZRNbhQxEIU9sMsqCWukMNmjITkDN+AacCBW2SH1FXqk3iJRTknZsOlyn8DhAHZj
	3iv3ZCSgNBqN/fxVvfLPhGH4+NlMROpLyPdPwxCGbzkbIsoWs+HzdQgPb83yc7JzcOHPixC+mCWbRVs
	pY2lNMMz2FMIOurZpREz4LtPU6qOly/A6G9aW0krjLAJcSgcICycxRCoXWmurHcKrvHC+eDauR7oWn2
	9cQEwExrEXa7/tJlyn9gsC/DhBdWpreheun7X1KJxybF0zhLwsnsyJ/rU4AbtYPXViyxQNQlrXWTCsJ
	6GudSNWT0NXblkVuwjBlkWVJrmaAMMJqarlLCgIcWLGGZ3yj+NRXoiqYMZRfnQBQ7VIIiKVYmUnJiyr
	bjfrItJGT9eLq7hgVhV2RTa7R5XNLttjBtQ4ksKF6ESMFERfOpfZiTzPxYnCNMw1x62G9Y2gUFkeJXo
	NIyLKGpXNrHHeCJMyuaujMNdktgkR4+au3MLaBd5cCEc02GrFVlZexk7MzCCV2wzf6OJEzN41d5VtqG
	01oIhvnx8kkGi5H22edTzHVDci52R6OkAyEnPOnUAfY6NR3iGYSu4qJfPTbS5oo9tOUMHbdKE23oTci
	3cBil8dtoGZk0BF2Yq35wSeWvYeT2EE/KnhRzorfMMgDmH3vr9szxa5TVz2dBl2dyyRfV6k76A93l6G
	8GbPEj2T+kfi/kPAP8D93f6vuL0H8BCu7v+Jq3ARhvDfGP4AtLxO3F/uHbUAAAAASUVORK5CYII=
X-Eric-Conspiracy: There is no conspiracy.
X-Spam-Score: -1.9 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160468>

--nextPart2785043.hmix7RS3Av
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In <20101031202433.GB21240@burratino>, Jonathan Nieder wrote:
>Boyd Stephen Smith Jr. wrote:
>> Signed-off-by: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
>> ---
>>=20
>>  templates/hooks--update.sample |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>=20
>> In one project I'm in we are using a centralized Git repository that many
>> developers have access to.  As such, we want to prevent tags from being
>> created by push operations and have them created by the administrators.
>>=20
>> This is a modification to the sample update hook to allow this to simply
>> be a configuration option.
>
>This kind of justification belongs above the "---", I think.

Eh, poop.  I wasn't sure were it went since it's been so long since I sent =
a=20
patch in.  I thought only the "commit message" went above the "---" and my=
=20
explanation seemed a bit over-long for a commit message.

I'll STFW next time and get it correct; I'd like to make it easy to use git=
 am=20
or git apply on the mail so that it is easier to review.

>No opinion on the functionality itself.  Just:
>> --- a/templates/hooks--update.sample
>> +++ b/templates/hooks--update.sample
>> @@ -7,6 +7,9 @@
>>=20
>>  #
>>  # Config
>>  # ------
>>=20
>> +# hooks.allowannotated
>> +#   This boolean sets whether annotated tags will be allowed into the
>> +#   repository.  By default they won't be.
>
>hooks.denyannotated (defaulting to false) would be more consistent
>with hooks.denycreatebranch, no?

Most of the flags were allow* and that seems to be a better way to approach=
=20
access restrictions like this.  denycreatebranch is the odd one out, and I =
was=20
considering a patch that would change it to an allow* as well.

Still, I'm happy to change the new flag to a deny* if there's consensus tha=
t=20
it is better implemented that way.

>Or maybe hooks.denycreatetag ---=20

That's probably better if you think of this as being analogous to=20
denycreatebranch.  When I wrote the patch I was thinking of this flag as be=
ing=20
analogous to allowunannotated.

>a situation in which unannotated
>tags should be allowed but annotated denied seems hard to imagine.

Agreed.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/

--nextPart2785043.hmix7RS3Av
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkzObGMACgkQ55pqL7G1QFkqXwCdFhHs8sJmur5D5p7tdTNdoIcb
MpYAn1NDsz6Gz46IdF+c8jc6+HDi+ml7
=6f+p
-----END PGP SIGNATURE-----

--nextPart2785043.hmix7RS3Av--
