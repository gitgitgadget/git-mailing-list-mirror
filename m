From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2 build issues
Date: Fri, 18 Aug 2006 13:14:33 -0700
Organization: YPO4
Message-ID: <20060818131433.4b6d36f0.rdunlap@xenotime.net>
References: <20060814121156.84bc6e34.rdunlap@xenotime.net>
	<20060815061056.GB4543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 22:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEAgs-0002TN-So
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 22:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWHRULf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 16:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWHRULf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 16:11:35 -0400
Received: from xenotime.net ([66.160.160.81]:30344 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932500AbWHRULf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 16:11:35 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <git@vger.kernel.org>; Fri, 18 Aug 2006 13:11:31 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060815061056.GB4543@coredump.intra.peff.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25693>

On Tue, 15 Aug 2006 02:10:56 -0400 Jeff King wrote:

> On Mon, Aug 14, 2006 at 12:11:56PM -0700, Randy.Dunlap wrote:
> 
> > xmlto -m callouts.xsl man git-add.xml
> > I/O error : Attempt to load network entity
> > http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> 
> It looks like your docbook installation is broken. You should have
> an xml catalog file that translates the url to a local file
> reference for the docbook stylesheet. Can you verify the integrity
> of / reinstall your docbook package?

You got it.  Thanks.

---
~Randy
