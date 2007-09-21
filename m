From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Fri, 21 Sep 2007 12:20:01 +0200
Message-ID: <200709211220.05434.simon@lst.de>
References: <119022570352-git-send-email-git@davidb.org> <20070920151637.GA26873@old.davidb.org> <7vodfxj6db.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1543943.fP3Cz6r0lx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: David Brown <git@davidb.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 12:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYfcP-0007dM-Th
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 12:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbXIUKUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbXIUKUL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 06:20:11 -0400
Received: from esparsett.troll.no ([62.70.27.18]:54437 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbXIUKUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 06:20:10 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 76032742AB; Fri, 21 Sep 2007 12:20:08 +0200 (CEST)
Received: from luria.local (unknown [172.20.1.24])
	by esparsett.troll.no (Postfix) with ESMTP
	id 61F10742A4; Fri, 21 Sep 2007 12:20:08 +0200 (CEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <7vodfxj6db.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58838>

--nextPart1543943.fP3Cz6r0lx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 September 2007 00:53:52 Junio C Hamano wrote:
> David Brown <git@davidb.org> writes:
> > On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
> >>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
> >>> git-p4 was missing the execute bit setting if the file had other
> >>> attribute bits set.
> >>> ---
> >>
> >>I'm fine with this, so unless you find a better way:
> >>
> >>Acked-By: Simon Hausmann <simon@lst.de>
> >
> > I sent out an improved version of this patch yesterday
> > <1190232768445-git-send-email-git@davidb.org> that I'd like to get
> > approved.  I guess I'm not quite sure what happens at this point with a
> > patch.
>
> I still have that *768445* message as "the last one proposed as
> better than previous ones" in my mbox.
>
> Simon?

Indeed, the new improved version is much better :)

Acked-By: Simon Hausmann <simon@lst.de>


Simon

--nextPart1543943.fP3Cz6r0lx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG85rVWXvMThJCpvIRAvZ+AJwKzE5bykbBT4ip3n5ipRvybP1t4gCgmHMm
exKQ6j+Qj+J/1IueyU4XXI0=
=Zb5h
-----END PGP SIGNATURE-----

--nextPart1543943.fP3Cz6r0lx--
