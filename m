From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail, with change
 from GPLv2 to GPLv2+.
Date: Tue, 23 Feb 2010 10:23:46 -0800
Message-ID: <87sk8rvmj1.fsf@yoom.home.cworth.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	<87tytdiqob.fsf@steelpick.localdomain>
	<alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	<873a0xhwxs.fsf@yoom.home.cworth.org>
	<alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	<87eikfhec1.fsf@yoom.home.cworth.org>
	<7vaav3bnr5.fsf@alter.siamese.dyndns.org>
	<87y6ilf4w7.fsf@yoom.home.cworth.org>
	<7vljekipnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 19:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjzQI-0000jb-M7
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 19:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0BWSXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 13:23:49 -0500
Received: from u15218177.onlinehome-server.com ([82.165.184.25]:53521 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0BWSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 13:23:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 89EED431FBF;
	Tue, 23 Feb 2010 10:23:49 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fbII85Fhgot; Tue, 23 Feb 2010 10:23:48 -0800 (PST)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 7E538431FAE;
	Tue, 23 Feb 2010 10:23:48 -0800 (PST)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id D4B8425427B; Tue, 23 Feb 2010 10:23:46 -0800 (PST)
In-Reply-To: <7vljekipnd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140822>

--=-=-=

On Mon, 22 Feb 2010 19:42:30 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Please drop the above the next time.

Oops. Yes, I missed that.

> FWIW, I only said "_at least_ you need consent from them", and it was not
> meant to be an exhaustive list.  "blame -C -C -C" may tell you more.

Fair enough.

> You are the party that wants this relicensing, not me.  Please do not
> burden me with excessive legwork for you, but help me a bit more
> proactively to make this happen.

I hope you see I haven't asked you to do any additional legwork. A
suggestion was made to construct a patch, which I did. You always have
the option of accepting or rejecting the patch as you see fit.

> Oh, I never said "do not use message ID".  I said "message ID alone is not
> good enough for most people".  Users of gmane and notmuch who know the
> tool they use would benefit from having message ID, _too_, but even if you
> were a user of notmuch, unless you have subscribed to the list and have
> your own archive, you wouldn't be able to say "show id:frotz".

Certainly. My assumption was that in a commit message for git, readers
would naturally assume that a message ID with no additional
specification could be found in the archives of the standard git mailing
list, (which is the case here). Otherwise, I would have qualified the
message ID more specifically.

-Carl

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFLhB0y6JDdNq8qSWgRAiwEAKCki1ecxM9ER1gc2oYhYj527s7LTQCfbUhW
KmeGdMU+jf/znCoVZpcQhik=
=+/rP
-----END PGP SIGNATURE-----
--=-=-=--
