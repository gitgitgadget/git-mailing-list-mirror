From: Tristan Roussel <troussel@phare.normalesup.org>
Subject: Re: Question about rerere
Date: Thu, 6 Nov 2014 23:29:51 +0100
Message-ID: <AC58C459-3E1D-4C6A-B717-9609F29F78A6@phare.normalesup.org>
References: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org> <CA+39Oz4k97uKceBmaiz3z5m2sVZ6jtQS9s+UVCwixkF_Rn+U+A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 23:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmVZ0-0001EW-9D
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 23:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbaKFW3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 17:29:54 -0500
Received: from nef2.ens.fr ([129.199.96.40]:3673 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbaKFW3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2014 17:29:53 -0500
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef2.ens.fr (8.13.6/1.01.28121999) with ESMTP id sA6MTqa0012562
          ; Thu, 6 Nov 2014 23:29:52 +0100 (CET)
Received: from [192.168.1.31] (dan75-4-82-239-58-136.fbx.proxad.net [82.239.58.136])
	by phare.normalesup.org (Postfix) with ESMTPSA id 15A7248002;
	Thu,  6 Nov 2014 23:29:52 +0100 (CET)
In-Reply-To: <CA+39Oz4k97uKceBmaiz3z5m2sVZ6jtQS9s+UVCwixkF_Rn+U+A@mail.gmail.com>
X-Mailer: Apple Mail (2.1990.1)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef2.ens.fr [129.199.96.32]); Thu, 06 Nov 2014 23:29:52 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 6 nov. 2014 =C3=A0 18:03, Thomas Adam <thomas@xteddy.org> a =C3=A9=
crit :
>=20
> On 6 November 2014 11:30, Tristan Roussel <troussel@phare.normalesup.=
org> wrote:
>> Hello,
>>=20
>> I=E2=80=99ve just learnt about rerere and it=E2=80=99s going to make=
 my life so much easier, I have a question though.
>>=20
>> I enabled rerere very lately and I wanted to know if there was a way=
 to feed rerere with old merge conflict resolutions (and if not, would =
it be considered a good feature request)? I=E2=80=99d like to do a reba=
se of my work because I unintentionally merged a branch I didn=E2=80=99=
t want and the merge is a bit far in the git history and I don=E2=80=99=
t want to re-resolve merge conflicts I had after that.
>=20
> Have a look at contrib/rerere-train.sh
>=20
> -- Thomas Adam

Thank you very much for the advice (and sorry for not searching enough)=
=2E