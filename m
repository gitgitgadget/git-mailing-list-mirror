From: ycollette.nospam@free.fr
Subject: Re: Add a bugzilla website
Date: Mon, 18 Nov 2013 08:37:19 +0100 (CET)
Message-ID: <1186100344.320778474.1384760239079.JavaMail.root@zimbra35-e6.priv.proxad.net>
References: <20131115225709.GC314350@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Nov 18 08:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViJOr-0003Us-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 08:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab3KRHhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Nov 2013 02:37:34 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:59281 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3KRHh3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Nov 2013 02:37:29 -0500
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 34F24940184
	for <git@vger.kernel.org>; Mon, 18 Nov 2013 08:37:20 +0100 (CET)
In-Reply-To: <20131115225709.GC314350@vauxhall.crustytoothpaste.net>
X-Originating-IP: [93.31.210.54]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237978>


On most linux distro bugzilla website, there are some people dedicated =
to triaging bugs (finding duplicated bugs, asking for more informations=
, closing old and / or resolved bugs).
To have an efficient bugtracking tool needs to have some people dedicat=
ed to this.
But for the user, it's a better approach. For example, I do not need to=
 register to the devel list and I do not have to watch all mails to loc=
ate the one which concerns my bug.
It works nicely with fedora, magieia and other distro / tools, so I don=
't know why this shouldn't work fine with git ?
But as far as I can read, most people here are very reluctant to use a =
bugtracking tool ...

YC

----- Mail original -----
De: "brian m. carlson" <sandals@crustytoothpaste.net>
=C3=80: "ycollette nospam" <ycollette.nospam@free.fr>
Cc: git@vger.kernel.org
Envoy=C3=A9: Vendredi 15 Novembre 2013 23:57:09
Objet: Re: Add a bugzilla website

On Fri, Nov 15, 2013 at 10:40:47AM +0100, ycollette.nospam@free.fr wrot=
e:
> And the conclusion is ? No bugzilla tool installed because somebody
> want to build a gitbased bugzilla thing ?

Personally, I do not want Yet Another Bugzilla Account.  A project is
significantly less likely to get a patch from me if I have to create an
account to report a bug.  Most of the patches I send to various project=
s
are for bugs I've experienced and want to provide a fix for, so I send =
a
small number of patches to many projects.

I feel that the mailing list workflow ends up working very well for Git
and it provides a low barrier to entry for those that want to send just
one or two patches for problems that they're experiencing.  It also
allows me to see and comment on virtually every patch on the list, whil=
e
ignoring threads I am not interested in, a combination which is
difficult to achieve with a web-based bug tracker.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion onl=
y
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B18=
7
