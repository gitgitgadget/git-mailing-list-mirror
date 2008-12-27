From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
	use --signoff
Date: Sat, 27 Dec 2008 12:05:54 +0100
Message-ID: <20081227110554.GA9314@chistera.yi.org>
References: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org> <1230368596-6865-1-git-send-email-dato@net.com.org.es> <200812271204.15268.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 27 12:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGX0n-0005Bc-7H
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 12:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbYL0LF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 06:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbYL0LF5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 06:05:57 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1156
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbYL0LF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 06:05:56 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 1FDAC801BF66;
	Sat, 27 Dec 2008 12:05:55 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGWzS-0002RC-9Q; Sat, 27 Dec 2008 12:05:54 +0100
Content-Disposition: inline
In-Reply-To: <200812271204.15268.trast@student.ethz.ch>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103995>

* Thomas Rast [Sat, 27 Dec 2008 12:04:11 +0100]:

> Adeodato Sim=C3=B3 wrote:
> > +commit.signoff::
> > +	If set, 'git commit' will behave as if '-s' option was given.
> > +	Please use this option with care: by enabling it, you're stating
> > +	that all your commits will invariably meet the S-o-b
> > +	requirements for any project you send patches to. It's probably
> > +	best to only use it from your private repositories' .git/config
> > +	file, and only for projects who require a S-o-b as proof of
>                            ^^^^^^^^^^^^

> "projects which ..." or "projects that ...".  "Who" can only stand fo=
r
> people, not objects.

Good catch, thank you. Hopefully Junio can amend.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                                   Listening to: Miguel Bos=C3=A9 - Pue=
de que
