From: Chris Wright <chrisw@osdl.org>
Subject: Re: PATCH Documentation/git-rev-list.txt typo fix
Date: Fri, 16 Sep 2005 13:06:42 -0700
Message-ID: <20050916200642.GN8041@shell0.pdx.osdl.net>
References: <E1EG2Or-0005E2-Pw@jdl.com> <20050916142412.GA973@brainysmurf.cs.umu.se> <7vy85xotxt.fsf@assigned-by-dhcp.cox.net> <20050916200232.GM8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Peter Hagervall <hager@cs.umu.se>,
	jdl@freescale.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:07:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMUF-0005AB-Fv
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbVIPUHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbVIPUHE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:07:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161275AbVIPUHC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 16:07:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GK6gBo012023
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 13:06:43 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GK6gC3010038;
	Fri, 16 Sep 2005 13:06:42 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8GK6geI010037;
	Fri, 16 Sep 2005 13:06:42 -0700
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050916200232.GM8041@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8724>

* Chris Wright (chrisw@osdl.org) wrote:
> * Junio C Hamano (junkio@cox.net) wrote:
> > Peter Hagervall <hager@cs.umu.se> writes:
> > 
> > > This causes a mismatch in <emphasis> and <superscript> tags, one way of
> > > fixing it is having no more than one caret symbol per line, which is the
> > > only solution I found in the asciidoc documentation. Ugly, but it works.
> > 
> > Thanks.
> 
> This is breaking the build.  Reverting fixes the build...

Err, ignore me.  I was one patch behind.  That patch from Peter fixes
the broken build introduced by Jon.

thanks,
-chris
