From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:49:21 +0100
Message-ID: <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org> <1195488877.10573.29.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10-287913661"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonas Juselius <jonas.juselius@chem.uit.no>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9op-0002fn-Lo
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXKSQtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXKSQtj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:49:39 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:60581 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbXKSQti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:49:38 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iu9oW-0007OL-CQ; Mon, 19 Nov 2007 17:49:36 +0100
In-Reply-To: <1195488877.10573.29.camel@localhost>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65465>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10-287913661
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 19, 2007, at 5:14 PM, Jonas Juselius wrote:
> On Mon, 2007-11-19 at 17:05 +0100, Jakub Narebski wrote:
>> Do I understand correctly that you don't support cloning via git://
>> protocol?
>
> Yes, that is correct. The machine is behind a number of firewalls,  
> and I
> simply cannot be bothered to go through the bureaucracy...

You can create a repository on repo.or.cz then :)

As it is often the case different people happen to work on similar  
things without knowing each other.  I started http://repo.or.cz/w/ 
tutorial.git which is meant to be a big Beamer presentation that  
presents Git thoroughly.  I wrote some ideas but didn't start to  
write the slides.  Just in case you want to have a look.

One of the things you said in your guide is that Git is easy to  
learn.  I think this is wrong.  Git is way more complicated than most  
other SCMs, especially compared to SVN.  Its documentation is far  
behind, compared to what other SCMs have.  There is no real user  
guide and the man pages are incomplete, at best.  I know saying this  
is a bit harsh, especially to the people out there that are working  
and sending patches to improve the documentation, but I think we have  
to admit that it's true, even though Git is making progress on this  
aspect.

What I hope to achieve, when I'll have time to write my slides, is to  
have some sort of equivalent of the wonderful Autotools tutorial  
(http://www-src.lip6.fr/homepages/Alexandre.Duret-Lutz/ 
autotools.html) which is definitely the only thing you need to read  
when you want to learn the Autotools (which are also quite  
complicated, let's admit it).

Please don't flame me by saying that Git isn't hard to use and  
everything.  It's the typical reaction of people who know how the  
things work.  Git is pretty simple to use once you know how it  
works.  But compared to SVN (for instance) it's hard to learn.   
People have to change the way they work to take all the benefits of  
Git, and to do this, they have to understand why that new way of  
working differently is better for them.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-10-287913661
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQb6SwwE67wC8PUkRAox2AJ9P+V7jlyTBseou8O9Pqrn+tDfgLwCgnsg+
3f+5o7lTmVZIrDqZJcgcPNQ=
=a4yi
-----END PGP SIGNATURE-----

--Apple-Mail-10-287913661--
