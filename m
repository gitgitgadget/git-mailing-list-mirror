From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH 2/2] Re: git-gui: some French translation enhancements
Date: Sat, 21 Mar 2009 11:14:26 +0100
Message-ID: <20090321101426.GB12971@vidovic>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net> <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net> <20090320071316.GB5693@glandium.org> <1237559694.25283.46.camel@alexandre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 11:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkyFL-00034p-Pn
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 11:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZCUKOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 06:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZCUKOi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 06:14:38 -0400
Received: from out6.laposte.net ([193.251.214.123]:58085 "EHLO
	out5.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753576AbZCUKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 06:14:38 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8402.laposte.net (SMTP Server) with ESMTP id 13E3E700008B;
	Sat, 21 Mar 2009 11:14:28 +0100 (CET)
Received: from ? (91-164-138-157.rev.libertysurf.net [91.164.138.157])
	by mwinf8402.laposte.net (SMTP Server) with ESMTP id 6FCD87000086;
	Sat, 21 Mar 2009 11:14:27 +0100 (CET)
X-ME-UUID: 20090321101427458.6FCD87000086@mwinf8402.laposte.net
Content-Disposition: inline
In-Reply-To: <1237559694.25283.46.camel@alexandre-desktop>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-250)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmdenvhgvnhgurhgvughiucdlqdehtddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114033>


On Fri, Mar 20, 2009 at 10:34:54AM -0400, Alexandre Bourget wrote:     =
                                                                       =
                              =20
>
> Le vendredi 20 mars 2009 =E0 08:13 +0100, Mike Hommey a =E9crit :
> > On Fri, Mar 20, 2009 at 01:54:02AM +0100, Nicolas Sebrecht wrote:
> > IMHO, we should find a better way to say that than to use the "inde=
x"
> > word at all. This obviously applies to all uses of "index" in frenc=
h
> > where we avoided it in english.
> >
> > OTOH, the best I can find for "staging area" is "zone de pr=E9parat=
ion",
> > and that doesn't help finding a word for stage and unstage.
>
> "zone de pr=E9paration" sounds good to me.

I'm not sure we are doing more good than bad. The "index" is a
technical's Git word which has its own sense in Git.

We could provide a pure "only french terms" translation but I'm not sur=
e
it's the best way to work in software translation.

"Index" is a one of theses terms having a "special meaning in place".
It stands in English for "staging area" and could have the same meaning
in french mainly because we don't have a good french word to that
special use case.

"Index" as-is in the french po is NOT a non-sense. Also, french people
newbie in Git would easily find help for the index (most websites are i=
n
english).

--=20
Nicolas Sebrecht
