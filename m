From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git Survey summary
Date: Thu, 21 Sep 2006 11:56:17 -0400
Message-ID: <20060921155617.GB3934@spearce.org>
References: <fcaeb9bf0609120205m38a44571we21e05864c04a731@mail.gmail.com> <fcaeb9bf0609210712i125822c4gf8af3ecccdbd3d13@mail.gmail.com> <eeuapj$mgn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 17:57:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQQuX-0001i5-NP
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 17:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWIUP4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Sep 2006 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWIUP4V
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 11:56:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49307 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751290AbWIUP4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 11:56:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQQuL-0000ro-HH; Thu, 21 Sep 2006 11:56:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49D7820FB16; Thu, 21 Sep 2006 11:56:17 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eeuapj$mgn$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27480>

Jakub Narebski <jnareb@gmail.com> wrote:
> Nguy?n Th=E1i Ng?c Duy wrote:
>=20
> > =A0- A place to post bugs and feature requests (if bugzilla is too =
big,
> > maybe mantis?)
>=20
> Isn't this mailing list the place to post bugreports and feature requ=
ests
> (and of course patches)? Any bugtracker has to be tied to mailing lis=
t, and
> perhaps also two-way to gitweb (gitweb making links to bugtracker iss=
ues,
> bugtracker having links to gitweb; perhaps incrementing revision
> numbers...).

Its funny, some communities are based around their bug tracking
systems (Mozilla) and others around their mailing lists (kernel, git).
Both work, but only if those participating make it so.  Trying to
force one type of community into another model can kill it.

I'm all for hyperlink integration of gitweb and bug tracking systems
but bug tracking tends to be a personal preference; there's so
many choices.  So whatever support is in gitweb needs to be pretty
modular to allow users to drop in the configuration for whatever
bug tracking system a given repository uses.


Since Git uses a mailing list model it would be nice if the gitweb
hyperlinks were into the marc and GMane archives by Message-ID; but
that would also require that commits start including the Message-ID
of the thread which spawned the patches.  It would also be nice
if the links were able to jump to the discussion about the patch,
as sometimes the patch thread is different from the spawning thread.

--=20
Shawn.
