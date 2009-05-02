From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 3 May 2009 01:32:32 +0200
Message-ID: <20090502233232.GD6135@atjola.homenet>
References: <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <20090424231632.GB10155@atjola.homenet> <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com> <20090502155348.GB6135@atjola.homenet> <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com> <20090502211110.GC6135@atjola.homenet> <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 01:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0OhV-0006b9-09
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 01:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZEBXcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbZEBXcg
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 19:32:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:50617 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752343AbZEBXcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 19:32:36 -0400
Received: (qmail invoked by alias); 02 May 2009 23:32:34 -0000
Received: from i59F5A4EE.versanet.de (EHLO atjola.local) [89.245.164.238]
  by mail.gmx.net (mp055) with SMTP; 03 May 2009 01:32:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19AvpcmmSRAJv1lDGaL5sltrLtnMmTFR1EVBAbTHM
	Pp9lWxADUknUBf
Content-Disposition: inline
In-Reply-To: <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118148>

On 2009.05.02 18:13:24 -0500, Michael Witten wrote:
> 2009/5/2 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> >> In any case, I *think* my point is that it's important to understa=
nd
> >> that git uses content addressing; at first I was emphatic about th=
e
> >> idea of 'addressing', so I went with pointer terminology (which wo=
rks
> >> quite well, in my opinion). However, I think the 'content' part is
> >> more important, which is why 'object hash' is loads better than
> >> 'object name' or 'object id'. Also, at least the documentation cou=
ld
> >> say that 'objects are addressed by their hashes', which says a who=
le
> >> lot in one quick sentence about how git works.
> >
> > Hm, like chapter 7 "Git concepts"?
>=20
> That's exactly the problem. It should be in chapter 0.

I'm not opposed to re-ordering stuff. Though I often think that having
commands and concepts "together" is better.  Maybe we just need that
twice? Once the plain data model, and once a "hands on" version where
the effects of the commands are described in terms of the data model.

The former "sucks" for those that want to just "dive in" (but might
still be happy to get told what their actions do), the latter sucks whe=
n
you just want to look something up.

Hm?

Bj=F6rn
