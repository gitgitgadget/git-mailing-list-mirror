From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules
Date: Mon, 4 Aug 2008 15:57:33 +0200
Message-ID: <20080804155733.46fd3982@pc09.procura.nl>
References: <20080731130626.GQ32184@machine.or.cz>
	<20080731170123.79e0d3e9@pc09.procura.nl>
	<8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	<20080731201530.067be667@pc09.procura.nl>
	<8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
	<20080801090422.55c6a45f@pc09.procura.nl>
	<8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com>
	<20080801123523.33c37e08@pc09.procura.nl>
	<8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com>
	<20080804152443.4418b3e0@pc09.procura.nl>
	<20080804134053.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Santi =?UTF-8?B?QsOpamFy?= <sbejar@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0aB-0004cj-HM
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYHDN5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 09:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYHDN5j
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:57:39 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:3153 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYHDN5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:57:38 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m74DvXae091003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 15:57:34 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080804134053.GK10151@machine.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91353>

On Mon, 4 Aug 2008 15:40:53 +0200, Petr Baudis <pasky@suse.cz> wrote:

> On Mon, Aug 04, 2008 at 03:24:43PM +0200, H.Merijn Brand wrote:
> > I do have to work with the repo, and that is more important than having
> > a perfect repo.
> 
> You might consider adopting a (relatively?) common strategy when
> importing historical projects: Actually start the history from scratch
> (git init && git add . && git commit -m"Initial commit") and fine-tune
> your historical import in a separate repository. Then, provide a script
> that people interested in the old history can run and it will graft the
> imported history to your pure-git history.

We already changed the approach for converting projects from SCCS to
create a recursive repo from all SCCS repo's. And that *is* perfect.

Problem with the current join/merge is that there already have been
commits to the git repo after the SCCS convert that I do not want to
loose.

> Conceptually, it should be pretty simple:
> 
> 	git fetch git://perl-company.nl/sccs-import.git
> 	echo initial_git_commit_sha1 last_imported_commit_sha1 \
> 		>>$(git rev-parse --git-dir)/info/grafts
> 
> Example of a fine-tuned script:
> 
> 	http://repo.or.cz/w/elinks.git?a=blob;f=contrib/grafthistory.sh
> 
> If you find out that the import is not perfect later on, you can just
> redo it, refetch and rewrite the info/grafts line.

I'll have a look at this anyway.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
