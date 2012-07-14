From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: What's cooking in git.git (Jul 2012, #04; Fri, 13)
Date: Sat, 14 Jul 2012 16:12:57 +0200
Message-ID: <20120714141257.GA2553@akuma>
References: <7vfw8v6wvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 16:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq35p-0006Gz-NQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 16:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab2GNONF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 10:13:05 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46879 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752655Ab2GNONC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 10:13:02 -0400
Received: (qmail invoked by alias); 14 Jul 2012 14:12:59 -0000
Received: from p5481FFC6.dip.t-dialin.net (EHLO gmx.net) [84.129.255.198]
  by mail.gmx.net (mp028) with SMTP; 14 Jul 2012 16:12:59 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18o75Buhh0oi8bN+WhILWKMjruofm0FOZTAQ0aPWw
	5hZEYUnIpCcX1f
Received: by gmx.net (sSMTP sendmail emulation); Sat, 14 Jul 2012 16:12:57 +0200
Content-Disposition: inline
In-Reply-To: <7vfw8v6wvl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201443>

Hi,

Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.
[...]
> [New Topics]
> 
> * as/t4012-style-updates (2012-07-12) 7 commits
>  - t4012: use 'printf' instead of 'dd' to generate a binary file
>  - t4012: Re-indent test snippets
>  - t4012: Make --shortstat test more robust
>  - t4012: Break up pipe into serial redirections
>  - t4012: Actually quote the sed script
>  - t4012: Unquote git command fragment in test title
>  - t4012: modernize style for quoting
> 
> Should I wait for a reroll???

  I see you did rewrite to "tail -n 1" already, updated the short log
and added the proposed 7th patch to this series. Good work!

  This only leaves addressing Zbigniew's comments to me. I would like
to do so. It will just take a few days though, until I find the time.

  As the whole series is not that important I think it should be OK to
wait a little longer, isn't it?

[...]

  Alexander
