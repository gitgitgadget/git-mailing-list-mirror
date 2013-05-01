From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Important articles on git-scm.com no more accessible
Date: Wed, 1 May 2013 22:57:51 +0400
Message-ID: <20130501225751.2959d21bf6dbf38579192315@domain007.com>
References: <20130501212839.c3c5df55da71c69fe11bf5f3@domain007.com>
	<20130501183801.GA2175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 01 20:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXcE9-0004wO-1h
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab3EAS6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:58:01 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:51746 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab3EAS57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:57:59 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r41IvpP1031305;
	Wed, 1 May 2013 22:57:52 +0400
In-Reply-To: <20130501183801.GA2175@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223125>

On Wed, 1 May 2013 14:38:02 -0400
Jeff King <peff@peff.net> wrote:

[...]
> > Recently I discovered that a number of useful articles which sort of
> > accompanied the "Pro Git" book are now inaccessible (404), namely:
> > "Smart HTTP Transport" [1], "Reset Demystified" [2], "Note to
> > Self" [3] and "Git Loves the Environment" [4].  I wonder if this is
> > a known problem and/or whom I could contact about this issue?
> > 
> > 1. http://git-scm.com/2010/03/04/smart-http.html
> > 2. http://git-scm.com/2011/07/11/reset.html
> > 3. http://git-scm.com/2010/08/25/notes.html
> > 4. http://git-scm.com/2010/04/11/environment.html
> 
> I think those links were broken by the site reorganization about a
> year ago. You can get to them at:
> 
>   http://git-scm.com/blog/2010/03/04/smart-http.html

Oh, I was about to respond that links I referred to are returned by
Google search for their respective article titles (it did so
yesterday).  So I went to verify this and just observed that Google
started to return liks pointing to (supposedly) Scott Chacon's site,
like

  http://scottchacon.com/2011/07/11/reset.html

for the "Reset demystified" article.  Hence I suppose Scott was
just transferring those articles to their new home.

> and so on. In general, problems with git-scm.com should be reported
> at:
> 
>   https://github.com/github/gitscm-next

Thanks!
