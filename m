From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of open + remove import of unused open2
Date: Sat, 08 Jun 2013 21:04:41 +0200
Message-ID: <vpqtxl8tody.fsf@anie.imag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
	<51B353A7.1090206@ensimag.fr> <vpqd2rwv40f.fsf@anie.imag.fr>
	<51B37BB0.7000504@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 21:04:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlORY-0002JW-HT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab3FHTEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 15:04:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57587 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab3FHTEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 15:04:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r58J4d6X023589
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 21:04:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlORN-0001ds-UO; Sat, 08 Jun 2013 21:04:41 +0200
In-Reply-To: <51B37BB0.7000504@ensimag.fr> (=?iso-8859-1?Q?=22C=E9lestin?=
 Matte"'s message of
	"Sat, 08 Jun 2013 20:45:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 21:04:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58J4d6X023589
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371323080.5545@rXn/lcw2Ub8b2Jwn2YOBcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226858>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> Oh, I thought a part of a patch was called a commit.

1 patch =3D 1 commit
1 patch series =3D several commits sent together. Will normally end-up =
in
                 a branch in Junio's repo (named with <initials>/<topic=
>)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
