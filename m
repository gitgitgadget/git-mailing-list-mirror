From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 09:47:41 -0400
Message-ID: <20071003134741.GQ21675@fieldses.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org> <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> <85abr0y5ua.fsf@lola.goethe.zz> <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> <85k5q4v6jb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id4aE-0000hV-TX
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 15:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbXJCNsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbXJCNsE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 09:48:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53218 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbXJCNsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 09:48:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Id4Zh-0001k9-IB; Wed, 03 Oct 2007 09:47:41 -0400
Content-Disposition: inline
In-Reply-To: <85k5q4v6jb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59838>

On Wed, Oct 03, 2007 at 12:25:44PM +0200, David Kastrup wrote:
> Wincent Colaiuta <win@wincent.com> writes:
>=20
> > El 3/10/2007, a las 10:12, David Kastrup escribi=C3=B3:
> >
> >> What with output in print, HTML, info?
> >
> > Yes, that's still a problem...
> >
> >> Personally, I think it might make sense to just step away from the
> >> AsciiDoc documentation to Docbook: plain text (without cutified
> >> formatting control like in AsciiDoc) can be generated _from_ Docbo=
ok.
> >
> > Yes, but editing DocBook (XML) is relatively painful compared to
> > editing plain text.
>=20
> The problem is that we are not editing plain text, but Docbook source
> masquerading as plain text.

I do a fair amount of editing of the asciidoc source, but 99% of it is
done by just blind imitation of what's already there.  I've never
learned docbook (I've barely learned asciidoc, to be honest), and with =
a
few (now forgotten) exceptions haven't tried to understand how the
toolchain works.

Maybe my experience would be the same with Docbook--I have no idea,
never having worked with it--but if you're suggesting that knowledge of
Docbook is a prerequisite for working with asciidoc, that certainly
hasn't been my experience.

> But it is not all _all_ easily writeable the moment you try to do
> something with _structural_ impact.  In fact, it is pretty much
> impossible for anybody except wizards to do that.  And when the
> wizards do it, they can't actually document what they have been doing
> since that would mean cluttering the purported "plain text
> documentation" with formatting comments.

I'm not sure what you're talking about here.  Example?

--b.
