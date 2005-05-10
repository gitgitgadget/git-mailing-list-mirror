From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 18:41:50 +0100
Message-ID: <20050510174150.GA2072@infradead.org>
References: <2cfc40320505100800426d38ca@mail.gmail.com> <1115739511.16187.432.camel@hades.cambridge.redhat.com> <2cfc4032050510092238259b63@mail.gmail.com> <1115744609.16187.455.camel@hades.cambridge.redhat.com> <2cfc403205051010151304d88a@mail.gmail.com> <2cfc4032050510101553d391b2@mail.gmail.com> <1115745912.16187.468.camel@hades.cambridge.redhat.com> <2cfc4032050510103664ebef28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 19:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVYdA-0004RL-TI
	for gcvg-git@gmane.org; Tue, 10 May 2005 19:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVEJRmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 13:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEJRmI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 13:42:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261722AbVEJRlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 13:41:53 -0400
Received: from hch by pentafluge.infradead.org with local (Exim 4.43 #1 (Red Hat Linux))
	id 1DVYju-0000Yb-B2; Tue, 10 May 2005 18:41:50 +0100
To: jon@blackcubes.dyndns.org
Content-Disposition: inline
In-Reply-To: <2cfc4032050510103664ebef28@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 at 03:36:29AM +1000, Jon Seymour wrote:
> This might surprise you, but everything in the world is not a unix
> command line. Using tools designed for use on a unix command line in a
> highly interactive environment like Eclipse would produce an
> abominably clunky result.


The unix commandline is an highly interactive enviroment aswell,
and supports scripting in addition :)

> I have already explained all the pragmatic reasons for doing a GIT
> implementation in Java but you are prepared to ignore all of those
> reasons. You have ignored all these reasons rather than lift a finger
> to compose a well-reasoned rebuttal.

You tried to argue for re-inventing the wheel.  Fortunately you are
allowed to reinvent the wheel here (which isn't given anymore these
days).  Just don't expect any support from people who have been burnt
by that before.  And the Java world is re-inventing the wheel far to
often - I suspect that'll be cured when the community gets more mature
in a few years..

> Instead you cling to a dogmatic insistence that GIT respositories only
> be accessed via the C toolsets.

The C toolchain is a well-defined interface.  One that makes a lot
of sense.

