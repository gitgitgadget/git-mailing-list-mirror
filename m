From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe: Avoid unnecessary warning when using --all
Date: Fri, 26 Dec 2008 16:26:27 -0800
Message-ID: <20081227002627.GA21386@spearce.org>
References: <20081226220201.GA20516@spearce.org> <7vmyeijws2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGN22-0002DI-37
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbYL0A03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 19:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYL0A02
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:26:28 -0500
Received: from george.spearce.org ([209.20.77.23]:35987 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYL0A02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:26:28 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DDF7338200; Sat, 27 Dec 2008 00:26:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmyeijws2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103969>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Patch-by: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> > Signed-off-by: Shawn O. Pearce <sop@google.com>
>=20
> Yeah, do you prefer to be known as "sop" over "spearce" these days, b=
y the
> way?  It does not make a difference to me but I just noticed that Aut=
hor
> and S-o-b won't be matching, so I am just being curious.

Whoops.

I use spearce@spearce.org for my Git work so the S-o-b line above
is wrong.  I just fixed it in my development repository on the work
system I used to make this patch.

Having two personalities is hard...  ;-)

Can you please amend to use my normal spearce@spearce.org address?

--=20
Shawn.
