From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/merge-strategies.txt, diff-options:
	grammar
Date: Tue, 6 Jan 2009 04:38:42 -0500
Message-ID: <20090106093842.GA10697@coredump.intra.peff.net>
References: <1231213956-14929-1-git-send-email-jidanni@jidanni.org> <200901060944.09435.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jidanni@jidanni.org, git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK8Pw-0003xD-D2
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbZAFJip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbZAFJip
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:38:45 -0500
Received: from peff.net ([208.65.91.99]:47664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbZAFJio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:38:44 -0500
Received: (qmail 943 invoked by uid 107); 6 Jan 2009 09:39:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Jan 2009 04:39:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2009 04:38:42 -0500
Content-Disposition: inline
In-Reply-To: <200901060944.09435.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104672>

On Tue, Jan 06, 2009 at 09:44:06AM +0100, Thomas Rast wrote:

> jidanni@jidanni.org wrote:
> > @@ -11,7 +11,7 @@ resolve::
> >  recursive::
> >  	This can only resolve two heads using 3-way merge
> >  	algorithm.  When there are more than one common
> > -	ancestors that can be used for 3-way merge, it creates a
> > +	ancestor that can be used for 3-way merge, it creates a
> >  	merged tree of the common ancestors and uses that as
> >  	the reference tree for the 3-way merge.  This has been
> >  	reported to result in fewer merge conflicts without
> 
> I'm not a native speaker, but shouldn't this be worded
> 
>   When there _is_ more than one common _ancestor_ that ...
> 
> instead?

I am, and yes.

-Peff
