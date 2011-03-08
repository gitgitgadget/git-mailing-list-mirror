From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: In-depth git blame?
Date: Tue, 8 Mar 2011 07:48:08 +0100
Message-ID: <20110308064808.GF24660@m62s10.vlinux.de>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
 <20110302211545.GD20400@sigill.intra.peff.net>
 <20110302212951.GB24660@m62s10.vlinux.de>
 <20110302213437.GG20400@sigill.intra.peff.net>
 <20110302214445.GC24660@m62s10.vlinux.de>
 <AANLkTimLf1gS03j4p7G3CKQWJC-b+_+T=ktaZ5xcJtZc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jez <jezreel@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Mar 08 07:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwqiS-0000Xb-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 07:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1CHGsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 01:48:14 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:43931 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751261Ab1CHGsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 01:48:14 -0500
Received: (qmail invoked by alias); 08 Mar 2011 06:48:11 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp036) with SMTP; 08 Mar 2011 07:48:11 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/r4nAyRp/rkrOVCxmnJsgGbnCO91kBNjmBrwEHjF
	FzXGMRXZpQaX5M
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 853FFD401F; Tue,  8 Mar 2011 07:48:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTimLf1gS03j4p7G3CKQWJC-b+_+T=ktaZ5xcJtZc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168633>

On Mon, Mar 07, 2011 at 06:20:56PM -0500, Jonas Fonseca wrote:
> On Wed, Mar 2, 2011 at 16:44, Peter Baumann <waste.manager@gmx.de> wr=
ote:
> > [ Cc Jonas, because he might know more about that ]
>=20
> ... although he arrives late in the discussion.
>=20
> > On Wed, Mar 02, 2011 at 04:34:37PM -0500, Jeff King wrote:
> >> On Wed, Mar 02, 2011 at 10:29:51PM +0100, Peter Baumann wrote:
> >>
> >> > Hm. I guess pressing 'B' will blame the parent commit in tig. =A0=
But I
> >> > can't figure out how to navigate back to the old commit (before
> >> > pressing 'B')? =A0Any hints appreciated!
> >>
> >> No, it is "," (comma) from the blame viewer in tig to blame starti=
ng
> >> from the parent of the blamed commit of the highlighted line.
> >>
> > Thx, I didn't know that. Your help is really appreciated!
>=20
> Pressing 'B' in the blame view reloads the blame view based on the
> line/commit, which is currently selected. And as Jeff points out ','
> reloads based on the parent of the current commit.
>=20
> Tig is very poor in terms of history (search, blame, commit) so
> there's is no 'back' button.

Ah. That explain I didn't find any. Thx.

-Peter
