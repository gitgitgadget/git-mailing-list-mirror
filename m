From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 15:35:12 -0400
Message-ID: <20101022193512.GB13059@sigill.intra.peff.net>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9NNt-00037d-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab0JVTe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 15:34:29 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab0JVTe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:34:28 -0400
Received: (qmail 22578 invoked by uid 111); 22 Oct 2010 19:34:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 19:34:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 15:35:12 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159739>

On Fri, Oct 22, 2010 at 12:19:00PM -0700, Shawn O. Pearce wrote:

> > Probably the money that goes to the organization for such a project
> > should _not_ go through the SFC, and would have to be handled
> > separately. Which is no worse than JGit has it today; they just can=
't
> > receive the SFC services as regular git can.
>=20
> This is fine with the JGit folks, for now anyway.  We may revisit thi=
s
> and have JGit join SFC at some point in the future.  We might not.

Yeah, what I should have said to be more clear in my original email is:
JGit can do what they like with SFC, but there is no reason for this
caveat to prevent _Git_ from joining the SFC.  The JGit folks are no
worse off, and things are much better for Git.

I think it would be great if JGit could join SFC in the long run.

> > Basically what we need to decide on before signing is:
> >
> > =C2=A01. Who should sign? These people are basically speaking for g=
it as a
> > =C2=A0 =C2=A0 community. Related to (2) below.
>=20
> The people listed in 2 as the leadership structure of git.

Agreed (I should have written point (2) first. ;) ).

> I think a committee of at least 3 people and at most 5, any of whom
> can be a benevolent SFC liasion, is fine.  As far as selection goes,
> the committee can elect or remove a member through a majority vote,
> and should base its decisions based on surviving contributions to the
> code base, but shouldn't be tied to that (just in case someone
> contributes a lot of good code and then becomes a jerk).

That sounds reasonable to me. I'm not sure what documentation, if any,
we need for such a structure. I guess we have to outline it in the
agreement with the SFC, so that may be sufficient. We can ask Bradley
about it, too.

> But as you point out, there isn't much power involved here, so there
> isn't a lot of concern of it being abused.  The important thing (the
> copyright on the code) is still held by individual contributors, so
> there is very little value involved (just the handful of GSoC dollars
> each year).

Yeah. I don't see any need to tie any decision on SFC interaction into
any other part of how git is run. It should have nothing to do with how
actual coding or release management works. I'm sure there will be some
overlap in who is prominent in both areas, but it doesn't need to be so=
=2E

> > =C2=A03. How much money should we give to the SFC?
> [...]
> I agree, a non-zero number.  2-5%?  Any idea what is typical?

Either in the draft agreement or in the notes the number 10% is thrown
out as a common value for umbrella organizations to charge. That sounds
reasonable to me, as they are probably saving us at least that much in
taxes by being a proper non-profit.

-Peff
