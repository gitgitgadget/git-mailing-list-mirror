From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: Re: [PATCH 1/2] bash: Enable completion for external subcommands
Date: Tue, 23 Feb 2010 18:02:30 +0200
Message-ID: <20100223160230.GB837@reaktor.fi>
References: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi> <20100223155007.GB10772@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 17:02:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjxDb-0004Px-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 17:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0BWQCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 11:02:33 -0500
Received: from mx.reaktor.fi ([82.203.205.80]:55720 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab0BWQCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 11:02:32 -0500
Received: by mx.reaktor.fi (Postfix, from userid 1008)
	id 34565262D9; Tue, 23 Feb 2010 18:02:30 +0200 (EET)
Mail-Followup-To: Teemu Matilainen <teemu.matilainen@iki.fi>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20100223155007.GB10772@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140807>

On Tue, 23 Feb 2010, SZEDER G=E1bor wrote:

> On Tue, Feb 23, 2010 at 04:43:12PM +0200, Teemu Matilainen wrote:
> > This makes it possible to have completion also for external git
> > subcommands.
>=20
> this issue was raised a few weeks ago, and the discussion led to a
> similar patch back then.  However, Junio mentioned a few concerns
> regarding this approach, and, since it was v1.7.0-rc time and this wa=
s
> clearly a post v1.7.0 change, I didn't pursue the discussion and
> didn't send updated patches, and then forgot it completely.  I will
> try to find some time in the evening to get the commit messages in
> shape send out the updates.  In the meantime please have a look at
> Junio's concerns about this approach:
> http://thread.gmane.org/gmane.comp.version-control.git/138316/focus=3D=
138348

Ugh.  I *tried* to search the mailing list, but apparently failed...
=46unny that anyway we got almost identical solution.

Thanks for the pointer.  I'll be waiting for the new patch.

--=20
	- Teemu
