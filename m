From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [git-svn PATCH] Fix markup in git-svn man page
Date: Fri, 4 May 2007 01:06:20 -0700
Message-ID: <20070504080620.GC17526@muzzle>
References: <20070504070003.9117.75385.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjsoA-0006oN-DJ
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXEDIG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 04:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965730AbXEDIGZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:06:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37660 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965714AbXEDIGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:06:22 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4AE5B7DC0A1;
	Fri,  4 May 2007 01:06:20 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 04 May 2007 01:06:20 -0700
Content-Disposition: inline
In-Reply-To: <20070504070003.9117.75385.stgit@yoghurt>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46141>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Some of the existing markup was just plain broken, and some subcomman=
d
> options weren't indented properly.
>=20
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> ---
>=20
> I poked at the markup with a stick until it rendered well (as both ma=
n
> and html), but I really don't know much about asciidoc markup, so som=
e
> sanity-checking by a third party is probably a good idea.

I don't know much about it, either.  They take way too long for me to
build, so I've mostly just guessed the syntax based on the existing
documentation and let other people fix it for me :)

--=20
Eric Wong
