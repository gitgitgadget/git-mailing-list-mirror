From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sun, 23 Dec 2012 21:21:11 +0100
Message-ID: <20121223202111.GB29354@book-mint>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 21:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tms3E-0002VU-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 21:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab2LWUVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 15:21:19 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:49022 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2LWUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 15:21:18 -0500
Received: from [85.16.214.228] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Tms2r-0003th-QR; Sun, 23 Dec 2012 21:21:14 +0100
Content-Disposition: inline
In-Reply-To: <20121222173649.04C5B44119@snark.thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212090>

Hi,

On Sat, Dec 22, 2012 at 12:36:48PM -0500, Eric S. Raymond wrote:
> If we can agree on this, I'll start a public repo, and contribute my
> Python framework - it's more capable than any of the shell harnesses
> out there because it can easily drive interleaved operations on multiple 
> checkout directories.

Please share so we can have a look. BTW, where can I find your cvsps
code?

> Anybody who is still interested in this problem should contribute
> tests.  Heiko Voigt, I'd particularly like you in on this.

If it does not take to much effort I could port my tests to the new
framework. Since I currently are not in active need of cvs conversions
its not of big interest to me anymore. But if it does not take too much
time I am happy to help.

>From my past cvs conversion experiences my personal guess is that
cvs2svn will win this competition.

Cheers Heiko
