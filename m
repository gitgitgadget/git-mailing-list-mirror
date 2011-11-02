From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Wed, 2 Nov 2011 14:43:06 +0000 (UTC)
Message-ID: <loom.20111102T153631-769@post.gmane.org>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com> <20111101020841.GA8116@arf.padd.com> <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 15:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLc2M-0000h6-Fs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 15:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab1KBOnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 10:43:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:32954 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755469Ab1KBOnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 10:43:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RLc2D-0000ck-4m
	for git@vger.kernel.org; Wed, 02 Nov 2011 15:43:21 +0100
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 15:43:21 +0100
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 15:43:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184634>

Michael Wookey <michaelwookey <at> gmail.com> writes:
> Of course, I'd love to have git-p4 work seamlessly for this scenario.
> Even Perforce have a KB article on the limitation of the "apple"
> filetype with git-p4:
>=20
>   http://kb.perforce.com/article/1417/git-p4
>=20
"""
Step 2: Download Git-p4

Recommended version is ermshiperete=E2=80=99s branch, which is availabl=
e from:

https://github.com/ermshiperete/git-p4

Note: Omit the =E2=80=9Cgit-p4.py25=E2=80=9D file, which is an older ve=
rsion that is no longer
needed.
Avoid Kernel.org=E2=80=99s Version of Git-p4

Git=E2=80=99s main source at http://git-scm.com/download and
http://www.kernel.org/pub/software/scm/git/ contains an older version o=
f Git-p4
with limitations that ermshiperete=E2=80=99s branch avoids.
"""

I can almost guess _who_ wrote this KB ;)

But this is really frustrating. Why can't people just cooperate to make=
 sure the
version in the main branch is the latest?


Vitor
