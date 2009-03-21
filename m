From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] Re: git-gui: some French translation enhancements
Date: Sat, 21 Mar 2009 18:26:57 +0100
Message-ID: <20090321172657.GB32452@glandium.org>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net> <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net> <20090320071316.GB5693@glandium.org> <1237559694.25283.46.camel@alexandre-desktop> <20090321101426.GB12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 18:28:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll4zi-0001oZ-EP
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 18:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003AbZCUR0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 13:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbZCUR0y
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 13:26:54 -0400
Received: from vuizook.err.no ([85.19.221.46]:59058 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbZCUR0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 13:26:53 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Ll4y4-0004GY-EE; Sat, 21 Mar 2009 18:26:48 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Ll4yH-0008S7-GK; Sat, 21 Mar 2009 18:26:57 +0100
Content-Disposition: inline
In-Reply-To: <20090321101426.GB12971@vidovic>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114045>

On Sat, Mar 21, 2009 at 11:14:26AM +0100, Nicolas Sebrecht wrote:
>=20
> On Fri, Mar 20, 2009 at 10:34:54AM -0400, Alexandre Bourget wrote:   =
                                                                       =
                                =20
> >
> > Le vendredi 20 mars 2009 =E0 08:13 +0100, Mike Hommey a =E9crit :
> > > On Fri, Mar 20, 2009 at 01:54:02AM +0100, Nicolas Sebrecht wrote:
> > > IMHO, we should find a better way to say that than to use the "in=
dex"
> > > word at all. This obviously applies to all uses of "index" in fre=
nch
> > > where we avoided it in english.
> > >
> > > OTOH, the best I can find for "staging area" is "zone de pr=E9par=
ation",
> > > and that doesn't help finding a word for stage and unstage.
> >
> > "zone de pr=E9paration" sounds good to me.
>=20
> I'm not sure we are doing more good than bad. The "index" is a
> technical's Git word which has its own sense in Git.
>=20
> We could provide a pure "only french terms" translation but I'm not s=
ure
> it's the best way to work in software translation.
>=20
> "Index" is a one of theses terms having a "special meaning in place".
> It stands in English for "staging area" and could have the same meani=
ng
> in french mainly because we don't have a good french word to that
> special use case.
>=20
> "Index" as-is in the french po is NOT a non-sense. Also, french peopl=
e
> newbie in Git would easily find help for the index (most websites are=
 in
> english).

Except that the english version tends to move away from the "index"
term, in favour of "staging area", if my understanding of what was said
at GitTogether is right.

Mike
