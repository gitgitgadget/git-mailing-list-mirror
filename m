From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] some test fixes for msysGit
Date: Thu, 3 Feb 2011 10:29:31 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1102031028150.1541@bonsai2>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 17:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl240-0007rc-99
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 17:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241Ab1BCQ3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 11:29:38 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:52425 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932129Ab1BCQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 11:29:38 -0500
Received: (qmail invoked by alias); 03 Feb 2011 16:29:35 -0000
Received: from wid-mir-primary-delegated.net.wisc.edu (EHLO bonsai2.local) [144.92.20.210]
  by mail.gmx.net (mp066) with SMTP; 03 Feb 2011 17:29:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181yyII2lc1Mwuafae0f2/lVxfNYniz4OSHCb6pop
	bp89QYPcnmQLmb
X-X-Sender: gene099@bonsai2
In-Reply-To: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165981>

Hi,

On Thu, 3 Feb 2011, Pat Thoyts wrote:

> The following patches resolve some issues for msysGit running the v1.7.4 
> tests
> 
>  t/t3509-cherry-pick-merge-df.sh |    6 ++++--
>  t/t4120-apply-popt.sh           |    9 +++++++--
>  t/t5526-fetch-submodules.sh     |   32 ++++++++++++++++++--------------
>  t/t7407-submodule-foreach.sh    |    4 ++++
>  4 files changed, 33 insertions(+), 18 deletions(-)

I looked at the first three and think they are obviously fine.

As I mentioned, I would like to have a fix for the order in git-submodule. 
If you do not have the time, I will try to push aside some of the work I 
have to do here and investigate myself.

Ciao,
Dscho
