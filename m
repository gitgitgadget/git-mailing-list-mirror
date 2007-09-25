From: Jeff King <peff@peff.net>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 15:34:16 -0400
Message-ID: <20070925193416.GB8564@coredump.intra.peff.net>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Brown <pickscrape@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGAr-00061x-OZ
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbXIYTeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbXIYTeT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:34:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4836 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbXIYTeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:34:18 -0400
Received: (qmail 19374 invoked by uid 111); 25 Sep 2007 19:34:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Sep 2007 15:34:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2007 15:34:16 -0400
Content-Disposition: inline
In-Reply-To: <46F95CCC.4080209@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59158>

On Tue, Sep 25, 2007 at 09:09:00PM +0200, Andreas Ericsson wrote:

> We came to the same conclusion at our workplace. Email works great, but
> it's faster and better to just walk over to your colleague and ask what
> he/she thinks about something.

One of the projects I am working on does things this way, but I have to
admit that I miss the email code-review process. There are often small
fixups (stylistic, minor nits, "I would have done it this way...", etc)
that are worth pointing out at the time, but are more painful to go back
and correct much later.

And documenting those discussions can really help other developers
besides the author and reviewer.

-Peff
