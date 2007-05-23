From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: HTTP trees trailing GIT trees
Date: Wed, 23 May 2007 14:15:51 +0000 (UTC)
Message-ID: <loom.20070523T161537-175@post.gmane.org>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqrdJ-0000FX-NQ
	for gcvg-git@gmane.org; Wed, 23 May 2007 16:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbXEWOQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 23 May 2007 10:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbXEWOQH
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 10:16:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52057 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048AbXEWOQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 10:16:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hqrd9-0001LK-DB
	for git@vger.kernel.org; Wed, 23 May 2007 16:15:59 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2007 16:15:59 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2007 16:15:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48158>

Hi,

Petr Baudis <pasky <at> suse.cz> writes:
>=20
>   Hi,
>=20
> On Wed, May 23, 2007 at 04:01:33PM CEST, Panagiotis Issaris wrote:
> > I reported this to the person who had setup the repository:
> > http://article.gmane.org/gmane.comp.video.ffmpeg.devel/51151
> >=20
> > But unfortunately, the problem seems to remain.
> >=20
> > Is this a known problem, or might this be a bug or misconfiguration=
?
>=20
>   did any push happenned since the post-update hook was enabled? It
> takes effect only after the next push. So far,
>=20
> 	http://git.mplayerhq.hu/ffmpeg/info/refs
>=20
> and
>=20
> 	http://git.mplayerhq.hu/ffmpeg/refs/heads/master
>=20
> is still out-of-sync (keeping this in sync is what is the job of the
> post-update hook, or git-update-server-info respectively).
>=20

Yes, I'd think so, as M=C3=A5ns stated that he had enabled the hook on
2007-05-22 20:43:27. The last commit shown on http://git.mplayerhq.hu/
through gitweb occurred 25 minutes ago ("Wed, 23 May 2007 13:46:11 +000=
0").

Thanks for your fast reply.

With friendly regards,
Takis
