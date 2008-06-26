From: M <mrohrmoser@gmx.de>
Subject: Re: gitwiki/EclipsePlugin
Date: Thu, 26 Jun 2008 02:27:11 +0200
Message-ID: <4862E25F.20806@gmx.de>
References: <4862737E.6010502@gmx.de> <200806252055.46132.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 02:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBfMf-0006XW-12
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 02:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYFZA15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYFZA14
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 20:27:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:51031 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755295AbYFZA1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 20:27:15 -0400
Received: (qmail invoked by alias); 26 Jun 2008 00:27:13 -0000
Received: from p5496FE59.dip.t-dialin.net (EHLO [192.168.0.3]) [84.150.254.89]
  by mail.gmx.net (mp015) with SMTP; 26 Jun 2008 02:27:13 +0200
X-Authenticated: #955365
X-Provags-ID: V01U2FsdGVkX1+K7K8xdHKKfGx1e3HXSfk64I5+4khWwmN2SkHyka
	gEgwQf1Ku3A9Uu
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <200806252055.46132.robin.rosenberg.lists@dewire.com>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86379>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Robin,
first of all thanks for opening git to the eclipse users.

Robin Rosenberg schrieb:
| onsdagen den 25 juni 2008 18.34.06 skrev M:
|> Hi list,
|> I felt quite helpless when trying to get egit running as neither
|> http://git.or.cz/gitwiki/EclipsePlugin nor the README/INSTALL aren't
|> overly verbose.
|>
|> I put the idiot-proof recipe on
|> http://wiki.jcurl.org/index.php5?title=GitSvn#Eclipse_Plugin - maybe you
|> can weave it into either wiki or INSTALL?
|
| You mean they *are* overly verbose?

No, that's in fact a typo of mine. They are not overly verbose.

| Our INSTALL has a lot more details than your wiki,

Yes, surely. I didn't aim to best your wiki page (as it's THE opening
reference within my notes).

| so I'm not sure I understand your problem.

As I had never compiled or packaged an eclipse plugin before, I had my
trouble finding the relevant export and options. (Right-click, bla, and
so on).

Felt like a complete idiot at first glance. Which bothers neither you
nor me, but I almost dropped it. And that would have bothered me, so I
scratched that itch further and just recorded the successful "scratch" -
the recipe.

| ) 7: uncheck all *.test projects
| 	not important

the better.

| ) 10: restart eclipse with parameter -clean
| 	probably a good idea, though I have never needed it

fine if it does without -clean.

| We're going to set up an official update site in the not too distant
future.

That's great!

If you find the recipe (except steps 7 and 10) useful, put it into
INSTALL or the wiki page, otherwise forget about it.

Greetings,
	Marcus

P.S.: Thanks for the lightning-fast reply.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkhi4l8ACgkQO26gbdBiJqZaVQCfWNE3zzug+0tWEr4+86aIcYAj
zWAAnRuK+Uk0zhag7wt8AD+LZXXCRgzo
=3TJV
-----END PGP SIGNATURE-----
