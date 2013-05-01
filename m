From: Jeff King <peff@peff.net>
Subject: Re: Important articles on git-scm.com no more accessible
Date: Wed, 1 May 2013 14:38:02 -0400
Message-ID: <20130501183801.GA2175@sigill.intra.peff.net>
References: <20130501212839.c3c5df55da71c69fe11bf5f3@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed May 01 20:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbus-0003kz-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3EASiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:38:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab3EASiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:38:05 -0400
Received: (qmail 28225 invoked by uid 102); 1 May 2013 18:38:20 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 May 2013 13:38:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2013 14:38:02 -0400
Content-Disposition: inline
In-Reply-To: <20130501212839.c3c5df55da71c69fe11bf5f3@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223118>

On Wed, May 01, 2013 at 09:28:39PM +0400, Konstantin Khomoutov wrote:

> I maintain a local wiki at my $dayjob which contains a page dedicated
> to Git which, among other things, liks to various useful bits of
> information on the internets.
> 
> Recently I discovered that a number of useful articles which sort of
> accompanied the "Pro Git" book are now inaccessible (404), namely:
> "Smart HTTP Transport" [1], "Reset Demystified" [2], "Note to Self" [3]
> and "Git Loves the Environment" [4].  I wonder if this is a known
> problem and/or whom I could contact about this issue?
> 
> 1. http://git-scm.com/2010/03/04/smart-http.html
> 2. http://git-scm.com/2011/07/11/reset.html
> 3. http://git-scm.com/2010/08/25/notes.html
> 4. http://git-scm.com/2010/04/11/environment.html

I think those links were broken by the site reorganization about a year
ago. You can get to them at:

  http://git-scm.com/blog/2010/03/04/smart-http.html

and so on. In general, problems with git-scm.com should be reported at:

  https://github.com/github/gitscm-next

-Peff
