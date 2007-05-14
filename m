From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 10:53:15 +0200
Message-ID: <20070514085314.GY14859@MichaelsNB>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB> <20070514010831.GH4489@pasky.or.cz> <20070514020001.GX14859@MichaelsNB> <20070514023609.GI18276@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CC7kGhlJjTyMjSRG"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 14 10:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnWMy-0000cF-MM
	for gcvg-git@gmane.org; Mon, 14 May 2007 10:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbXENI5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 04:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXENI5X
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 04:57:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754600AbXENI5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 04:57:22 -0400
Received: (qmail invoked by alias); 14 May 2007 08:57:20 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp030) with SMTP; 14 May 2007 10:57:20 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX194+RBnDyt4HbupmN6LDcUNIDHi0bIcf1WFukIyYL
	X6CEnS4iF4n3ME
Content-Disposition: inline
In-Reply-To: <20070514023609.GI18276@pasky.or.cz>
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47228>


--CC7kGhlJjTyMjSRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 14, 2007 at 04:36:09AM +0200, Petr Baudis wrote:
> On Mon, May 14, 2007 at 04:00:02AM CEST, Michael Niedermayer wrote:
> > i agree with you that she will click on 'history' and figure out what i=
t is
> > but if she wants to see the contents of one of the files then i think
> > she will be confused and not know where to click,
>=20
> I think she will just click on the filename - straightforward enough...?

yes and no :)
i see 2 possible problems with this
first if she starts from the summary page (which is from where she would
start from if she clicked on 'ffmpeg') then she would see the recent=20
history but no directory/file names, she would have to click on 'tree'=20
here

the second possible problem i see is that while directory names are
displayed in iceweasel in underlined blue like links, filenames are
not, so she might not realize that she can click on them

another thing i just realized is that the blob/tree links on the tree
page seems redundant as the directory/file names already link to these
pages, iam just mentioning that as some people in this thread seemed to
like minimizing the number of links and the length of varous displayed
items

also file size and last modified dates would be interresting on the tree
page
viewvc displays on its equivalent page, time since last change
svn revission of the last change, the author/commiter of the last change
and the corresponding abbreviated log entry

[...]
--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

it is not once nor twice but times without number that the same ideas make
their appearance in the world. -- Aristotle

--CC7kGhlJjTyMjSRG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSCN6YR7HhwQLD6sRAhnuAJ48JF5njShZ2BigszlRoLCCWOcoDACeLwMa
YNBHXx1FgcWu6YBB9VDIuAQ=
=HO0O
-----END PGP SIGNATURE-----

--CC7kGhlJjTyMjSRG--
