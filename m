From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: Wrong help text on git status -h ?
Date: Tue, 13 May 2008 11:09:06 +0000 (UTC)
Message-ID: <loom.20080513T110711-862@post.gmane.org>
References: <loom.20080423T125136-135@post.gmane.org> <vpqfxtc36j4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvsOp-0007mr-II
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbYEMLJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 07:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbYEMLJY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:09:24 -0400
Received: from main.gmane.org ([80.91.229.2]:49103 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbYEMLJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:09:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JvsNh-000163-VO
	for git@vger.kernel.org; Tue, 13 May 2008 11:09:18 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 May 2008 11:09:17 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 May 2008 11:09:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82017>

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:

>=20
> Stefan N=C3=A4we <stefan.naewe+git <at> gmail.com> writes:
>=20
> > Getting help for commit on 'git status -h' can't be right, can it ?
> > Or am I missing something?
>=20
> I'd say: both.

Well, I can't be *that* wrong:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D478814

=20
> git status could have been spelled "git commit --dry-run", they're
> actually the same command, but "git status" stops before launching th=
e
> editor and doing the actual commit. So, they take the exact same set
> of options.
>=20
> That said, in an ideal world, "git status -h" would mention that the
> commit message options are ignored with "git status".
>=20

Regards,
   Stefan
