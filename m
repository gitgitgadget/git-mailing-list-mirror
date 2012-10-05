From: Dirk Heinrichs <dirk.heinrichs@altum.de>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Fri, 05 Oct 2012 07:35:08 +0200
Organization: Privat
Message-ID: <1611434.pfF2lutBRf@moria>
References: <k4hj91$4tt$4@ger.gmane.org> <CABURp0qVWg2PvD4PcjJ9q45x9WxJCuJEQL8Rze=qerWXg72Txw@mail.gmail.com> <k4jj5n$72b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2620133.qs4V63hIOs"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 08:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1bc-0005ad-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab2JEGlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:41:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2JEGlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:41:40 -0400
Received: from rohan.altum.de (pD9FF87AA.dip0.t-ipconnect.de [217.255.135.170])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MKPWk-1TIMfi1KNi-001gPp; Fri, 05 Oct 2012 07:35:16 +0200
Received: from moria.localnet (moria.altum.de [192.168.1.2])
	by rohan.altum.de (Postfix) with ESMTPS id 9AEE4136
	for <git@vger.kernel.org>; Fri,  5 Oct 2012 07:35:15 +0200 (CEST)
User-Agent: KMail/4.9.2 (Linux/3.5.0-16-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <k4jj5n$72b$1@ger.gmane.org>
X-Provags-ID: V02:K0:+0BzuSXNW4kBUmD9Gd8OKaFsttMQ2U4ayEqP8nQPyLl
 FzLyBygPpRHNhqHQRjvHbU6mru6nwELYCBQrJGoDGPTu9mNqPa
 cXZB9581FUEh6yX5NYMOVv0mTgigvlQAk/mwMw7mvzxO+Wetd/
 bx3E3sgh1lw0ONHExEPoD+BjTsVr68S3ctonb0b6NMeyddJU4D
 vwlRqkr5JrLUEAEFwaKFj2RZAlARJj5k9vyfh9OasfVamxoYA5
 4O/d2yOn8S6IlhfhRmf2vwI/1XOJDeTDtMWLcxP/Bi0f46Yo5V
 uCD6eUhKtmZQXE7tSV5hKh+eAGTEMXlZYB3b5kYEpK4DfsgW6C
 PmjUaT/ZwN5kfEx2b3Bo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207070>


--nextPart2620133.qs4V63hIOs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag 04 Oktober 2012, 10:59:36 schrieb Geoffrey De Smet:

> I personally use git reset a lot:
> - Try an experiment
> - Commit a few commits as the experiment progresses
> - figure out that the experiment is a dead end
> - git reset all those local commits

Hmm, what if you do your experiments on a dedicated branch? Branch deletion is 
"push-save", isn't it?

Bye...

	Dirk
-- 
Dirk Heinrichs <dirk.heinrichs@altum.de>
Tel: +49 (0)2471 209385 | Mobil: +49 (0)176 34473913
GPG Public Key C2E467BB | Jabber: dirk.heinrichs@altum.de

--nextPart2620133.qs4V63hIOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQBQbnGM8NVtnsLkZ7sRAqIGAKCaXvDQhyIZ3UWb5KOSeQFOop/m4wCeOOkz
Efi3ARl2IGOye1QXIZM35X4=
=tlH4
-----END PGP SIGNATURE-----

--nextPart2620133.qs4V63hIOs--
