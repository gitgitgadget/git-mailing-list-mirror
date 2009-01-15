From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Wed, 14 Jan 2009 20:49:50 -0600
Message-ID: <200901142049.54775.bss@iguanasuicide.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4972506.GT1CV6AiTD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 03:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNIKL-0008A7-EI
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 03:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZAOCt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 21:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZAOCt6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 21:49:58 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:38689 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZAOCt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 21:49:57 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090115024955.QLPD18445.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Wed, 14 Jan 2009 21:49:55 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 3epv1b00B2i4SyG02epveu; Wed, 14 Jan 2009 21:49:56 -0500
X-Authority-Analysis: v=1.0 c=1 a=J-l0xwG6isUA:10 a=sIHEJvGgCqYA:10
 a=Fq1VQ0LPAAAA:8 a=GUeTHOY1RRQaGJSFi4cA:9 a=ZhnCW_I2wurea1FXypMrcNIwmRAA:4
 a=qIVjreYYsbEA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=PSOKk12CDuk3a4pF8QsA:9 a=cw4voOoLDPrIs-Vxyo4NzOCO_msA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LNIIs-0002DN-Tk; Wed, 14 Jan 2009 20:49:55 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105758>

--nextPart4972506.GT1CV6AiTD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 14 January 2009, Junio C Hamano <gitster@pobox.com> wrote=20
about 'Re: [RFC PATCH] Make the rebase edit mode really end up in an edit=20
state':
>Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>> I always have a hard time figuring out what to do during an
>> interactive rebase. Recently, it dawned on me that the reason is that
>> I have to do different things: one thing when editing on purpose, and
>> a different thing when resolving a conflict.
>>
>> With this change, I propose to make the UI more uniform. I think that
>> the new way is more intuitive, too, if you will agree that a Git UI
>> can be intuitive.
>>
>> I expect this to not be acceptable due to compatibility concerns.
>
>We may need a version bump to 1.7.0 to update the UI for this command,
> but please do test rigorously to build a stronger case for a saner UI.

Instead of changing the meaning of edit, how about introducing a "replace"=
=20
command?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4972506.GT1CV6AiTD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklupE4ACgkQ55pqL7G1QFkaVwCeKb2WFG6naG3ojx/XLHHpqvQI
aQ8AoIAfK4Jy7+wVAclXSCtt3hvJuuSH
=go5+
-----END PGP SIGNATURE-----

--nextPart4972506.GT1CV6AiTD--
