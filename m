From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Wed, 24 Sep 2008 11:39:33 -0700
Message-ID: <20080924183933.GA30265@garry-thinkpad.arpnetworks.com>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann> <20080924175315.GA10337@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	vim@tpope.info, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:40:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiZI8-0005W9-Np
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYIXSji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 14:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYIXSji
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:39:38 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:52643 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752726AbYIXSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 14:39:37 -0400
Received: (qmail 15882 invoked from network); 24 Sep 2008 18:37:44 -0000
Received: from unknown (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 24 Sep 2008 18:37:44 -0000
Content-Disposition: inline
In-Reply-To: <20080924175315.GA10337@coredump.intra.peff.net>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96679>

On Wed, Sep 24, 2008 at 01:53:15PM -0400, Jeff King wrote:
> [Tim Pope cc'd as the author of the official version. Tim: just an FY=
I,
> but if you have any comments, please feel free to share]
>=20
> [Shawn cc'd as the interim maintainer. I, for one, welcome our
> new Java-programming overlords].
>=20
> On Wed, Sep 24, 2008 at 07:01:54PM +0200, SZEDER G=E1bor wrote:
>=20
> > > Is there any objection to simply removing it (and probably replac=
ing it
> > > with a note to go look at the official highlighting file)?
> > I'm for it, because I didn't know that there is an official git syn=
tax
> > highlight file out there.  Indeed, I haven't even know that vim 7.2=
 is
> > out.
>=20
> Here is a patch, then. Shawn, we should probably give any vim users a
> few days to object in case there is something they don't like about t=
he
> upstream version, but other than that, I think this should be applied=
 to
> master.

As a Vim user, I think removing the syntax file, and giving a
reference to the official one, is fine.

--=20
Garry Dolley
ARP Networks, Inc.
http://scie.nti.st
Los Angeles County REACT, Unit 336
WQGK336
