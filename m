From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH 2/2] Re: git-gui: some French translation enhancements
Date: Sat, 21 Mar 2009 11:27:48 +0100
Message-ID: <20090321102748.GC12971@vidovic>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net> <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net> <20090320071316.GB5693@glandium.org> <1237559694.25283.46.camel@alexandre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 11:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkySC-00068k-30
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 11:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbZCUK1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 06:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbZCUK1x
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 06:27:53 -0400
Received: from out2.laposte.net ([193.251.214.119]:63140 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754496AbZCUK1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 06:27:52 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8212.laposte.net (SMTP Server) with ESMTP id B868E700008B;
	Sat, 21 Mar 2009 11:27:49 +0100 (CET)
Received: from ? (91-164-138-157.rev.libertysurf.net [91.164.138.157])
	by mwinf8212.laposte.net (SMTP Server) with ESMTP id 27DA67000088;
	Sat, 21 Mar 2009 11:27:48 +0100 (CET)
X-ME-UUID: 20090321102749163.27DA67000088@mwinf8212.laposte.net
Content-Disposition: inline
In-Reply-To: <1237559694.25283.46.camel@alexandre-desktop>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-200)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114034>


On Fri, Mar 20, 2009 at 10:34:54AM -0400, Alexandre Bourget wrote:

> Hmm.. if you look at the git-gui program, when we use "Revert", it's =
not
> always the usage of the git-revert command that is invoked.
>=20
> Most of the time, it's the equivalent of running "git reset --hard", =
or
> "git checkout path/filename.ext" (in fact, it uses git-checkout-index=
,
> see git-gui/lib/index.tcl::revert_helper..).
>=20
> That is true for example in the "Commit" menu, 3rd to last item, whic=
h
> reads in french "Inverser les modifications" or "R=E9voker les
> modifications" as I modified it at some point.
>=20
> What happens here, is really not inversion of modifications; we're ju=
st
> wiping out all changes from the working dir, back to HEAD. Several of
> the translated messages are used in *that* context.=20

Good point. Thanks.

--=20
Nicolas Sebrecht
