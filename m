From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Sun, 11 Nov 2012 12:41:36 -0500
Message-ID: <20121111174136.GC13188@sigill.intra.peff.net>
References: <20121029102114.GA14497@sigill.intra.peff.net>
 <5092C234.9000307@ramsay1.demon.co.uk>
 <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
 <20121102094259.GA28414@sigill.intra.peff.net>
 <20121102095632.GA30221@sigill.intra.peff.net>
 <50943C1A.4090706@ramsay1.demon.co.uk>
 <20121104122926.GD336@sigill.intra.peff.net>
 <509E9E02.3000500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbXd-0005vI-EH
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab2KKRlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:41:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44034 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab2KKRlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:41:39 -0500
Received: (qmail 2578 invoked by uid 107); 11 Nov 2012 17:42:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 12:42:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 12:41:36 -0500
Content-Disposition: inline
In-Reply-To: <509E9E02.3000500@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209426>

On Sat, Nov 10, 2012 at 06:33:38PM +0000, Ramsay Jones wrote:

> > We should probably wrap it. I'm planning to queue this on top of Chris's
> > patch:
> 
> Unfortunately, I haven't had time yet to test this patch. (Early this week, I
> went into hospital for a "minor" surgical procedure - I have not yet fully
> recovered). The patch looks good and I don't anticipate any problems. I will
> hopefully test it soon (I see it's in pu now) and let you know.

Thanks. I merged it to "next" on Friday, so we will see if anybody
screams. But please take your time and recover. Git will wait. :)

-Peff
