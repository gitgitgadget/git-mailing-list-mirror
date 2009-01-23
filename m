From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn fails to fetch repository
Date: Fri, 23 Jan 2009 14:22:18 +0100
Message-ID: <20090123132218.GB523@atjola.homenet>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org> <496CD49D.1070201@drmicha.warpmail.net> <loom.20090113T185918-397@post.gmane.org> <20090113203922.GD30404@atjola.homenet> <loom.20090113T204616-845@post.gmane.org> <20090123085235.GA14721@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vladimir Pouzanov <farcaller@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQM14-0001U9-P8
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 14:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbZAWNWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 08:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755884AbZAWNWq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 08:22:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:55579 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755722AbZAWNWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 08:22:46 -0500
Received: (qmail invoked by alias); 23 Jan 2009 13:22:44 -0000
Received: from i577B96D3.versanet.de (EHLO atjola.local) [87.123.150.211]
  by mail.gmx.net (mp065) with SMTP; 23 Jan 2009 14:22:44 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+YgqtZ05+YCnGYjbwBXIR3xhu2yh7oVlyiY/fkJd
	+b60DQodljl6RO
Content-Disposition: inline
In-Reply-To: <20090123085235.GA14721@machine.or.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106882>

On 2009.01.23 09:52:35 +0100, Petr Baudis wrote:
> On Tue, Jan 13, 2009 at 08:46:55PM +0000, Vladimir Pouzanov wrote:
> > Bj=F6rn Steinbrink <B.Steinbrink <at> gmx.de> writes:
> > > Is that Linux box using Gentoo? If so, try emerging subversion wi=
th -dso
> > > in your build flags.
> >=20
> > Yeah, that's gentoo. Will try rebuilding svn now.
>=20
> I have hit the same issue (segfault on Gentoo) and this fixed it for =
me.
> But do you have any details on why is the segfault caused and how to
> prevent it? USE=3Ddso is the default on Gentoo. :-(

No idea, I just heard about that in #git. IIRC it was Mikachu who came
up with that solution. Unfortunately, he's not around at the moment, an=
d
I don't recall his real name, so not on Cc. :-/

Bj=F6rn
