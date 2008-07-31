From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 20:15:30 +0200
Message-ID: <20080731201530.067be667@pc09.procura.nl>
References: <20080730230336.GA6481@Hermes>
	<20080731092104.1a6ce8bd@pc09.procura.nl>
	<20080731143955.034f0577@pc09.procura.nl>
	<20080731130626.GQ32184@machine.or.cz>
	<20080731170123.79e0d3e9@pc09.procura.nl>
	<8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "Santi =?UTF-8?B?QsOpamFy?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOchi-0004Hb-4U
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYGaSPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 14:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbYGaSPo
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:15:44 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4675 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYGaSPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 14:15:43 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6VIFVep021198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 20:15:31 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90956>

On Thu, 31 Jul 2008 17:24:40 +0200, "Santi B=C3=A9jar" <sbejar@gmail.co=
m>
wrote:

> On Thu, Jul 31, 2008 at 17:01, H.Merijn Brand <h.m.brand@xs4all.nl> w=
rote:
> > On Thu, 31 Jul 2008 15:06:26 +0200, Petr Baudis <pasky@suse.cz> wro=
te:
> >
> >> On Thu, Jul 31, 2008 at 02:39:55PM +0200, H.Merijn Brand wrote:
> >> >
> >> > There is a slight problem with this merging approach. The path n=
ames
> >> > are as they are/were in the submodules. In module_a, foo.pl was =
without
> >> > a leading module_a/ path, and now after integration, it still is=
=2E Is it
> >> > possible to rethink this whole process that integrates/merges th=
e
> >> > several git repo's in subfolders into the current folder, as-if =
they
> >> > would have been in this folder in the first place?
> >>
> >> I would suggest re-reading Santi's suggestions:
> >>
> >> > You have, basically, two possibilities:
> >> >
> >> > 1) Add the module_# as submodules:
> >> >   http://www.kernel.org/pub/software/scm/git/docs/git-submodule.=
html
> >> >   http://git.or.cz/gitwiki/GitSubmoduleTutorial
> >> > 2) Add the submodules as subtrees (as gitk and git-gui in git.gi=
t)
> >> >   http://www.kernel.org/pub/software/scm/git/docs/howto/using-me=
rge-subtree.html
> >>
> >> I think the latter is specifically what you want.
> >
> > I got stuck in that process, as the new repo thinks all the files f=
rom
> > the sub-folders belong to the top-folder: After this process, there=
 are
> > a lot of files from subfolder include in the "new" top-level folder=
=2E
> >
>=20
> I see all OK. Can you provide a self consistent simple testcase that
> shows what is wrong?

Yes. was rather easy.
http://www.xs4all.nl/~hmbrand/testcase.tgz

test 133 > ll *
23875989 -rwxr-xr-x 1 merijn users   486 2008-07-31 20:08 git-join.sh
23875990 -rw-rw-rw- 1 merijn users 14385 2008-07-31 20:07 test-git.tgz

4gl:
total 16
23871493 drwxrwxrwx 4 merijn users 4096 2008-07-31 20:01 .
23871492 drwxrwxrwx 3 merijn users 4096 2008-07-31 20:08 ..
23871494 drwxrwxrwx 3 merijn users 4096 2008-07-31 19:56 fnc
23875966 drwxrwxrwx 3 merijn users 4096 2008-07-31 20:04 include
test 134 > bash git-join.sh
Creating merge environment
Recovering original repo's
Initializing new repo
Initialized empty Git repository in /work/lep/test/new/.git/
Merging include ...
Updating Binclude
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 9 (delta 1), reused 6 (delta 1)
Unpacking objects: 100% (9/9), done.
=46rom include
 * [new branch]      master     -> Binclude/master
Created commit c2c491e: Merge include as our subdirectory
 1 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 include/ini0.h
=46rom include
 * branch            master     -> FETCH_HEAD
Already up-to-date.
Merging fnc ...
Updating Bfnc
warning: no common commits
remote: Counting objects: 12, done.
remote: Compressing objects: 100% (4/4), done.
Unpacking objects: 100% (12/12), done.
remote: Total 12 (delta 0), reused 9 (delta 0)
=46rom fnc
 * [new branch]      master     -> Bfnc/master
Automatic merge went well; stopped before committing as requested
Created commit d7da4d6: Merge fnc as our subdirectory
=46rom fnc
 * branch            master     -> FETCH_HEAD
Already up-to-date.
Done
test 135 > ll new
total 24
23887892 drwxrwxrwx 5 merijn users 4096 2008-07-31 20:11 .
23871492 drwxrwxrwx 4 merijn users 4096 2008-07-31 20:11 ..
23887973 drwxrwxrwx 8 merijn users 4096 2008-07-31 20:11 .git
23887893 drwxrwxrwx 3 merijn users 4096 2008-07-31 20:11 fnc
23887933 drwxrwxrwx 3 merijn users 4096 2008-07-31 20:11 include
23888029 -rw-rw-rw- 1 merijn users   56 2008-07-31 20:11 ini0.h
test 136 > ll new/include/
total 16
23887933 drwxrwxrwx 3 merijn users 4096 2008-07-31 20:11 .
23887892 drwxrwxrwx 5 merijn users 4096 2008-07-31 20:11 ..
23887934 drwxrwxrwx 8 merijn users 4096 2008-07-31 20:04 .git
23888031 -rw-rw-rw- 1 merijn users   56 2008-07-31 20:11 ini0.h
test 137 >

What is ini0.h doing in new/ ?

test 137 > cd new
test/new 138 > git-ls-files
fnc/foo.txt
include/ini0.h
ini0.h
test/new 139 >


--=20
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org=
/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00=
,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin=
=2E
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org=
/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers=
/
