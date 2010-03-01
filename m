From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Mon, 1 Mar 2010 05:58:21 -0500
Message-ID: <20100301105821.GB25069@coredump.intra.peff.net>
References: <20100224154452.GA25872@coredump.intra.peff.net>
 <m3k4u2mxdr.fsf@localhost.localdomain>
 <20100226123945.GD10198@coredump.intra.peff.net>
 <201002261656.47740.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 11:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm3KZ-0008QP-D9
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 11:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab0CAK60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 05:58:26 -0500
Received: from peff.net ([208.65.91.99]:34564 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab0CAK6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 05:58:25 -0500
Received: (qmail 8711 invoked by uid 107); 1 Mar 2010 10:58:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Mar 2010 05:58:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Mar 2010 05:58:21 -0500
Content-Disposition: inline
In-Reply-To: <201002261656.47740.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141316>

On Fri, Feb 26, 2010 at 04:56:44PM +0100, Jakub Narebski wrote:

> > > I wouldn't say I am "key developer"...
> > 
> > Well, you have a lot of commits, anyway. ;)
> 
> Well, there are mainly (310 out of 398 in whole lifetime of git) about
> gitweb, which is rather disconnected subsystem of git, started by
> Kay Sievers.

True. In the final version I included you, but I marked up people with
their areas (so Paul is marked as "gitk", you are "gitweb", I note that
Shawn is the git-gui maintainer as well as the JGit maintainer, etc).

> > Yeah, I thought about that list, but it is very long. Honestly even
> > putting ten people on the list seems long to me. I think git has a very
> > different distribution of committers than many other projects.
> 
> Well, it at least lists contributors by subsystem...

Good point. I kept the list in the application itself more compact, but
gave a link to git-scm.com/about (as Julian suggested) for a longer list
of committers, and directly linked to Junio's MaintNotes to get more
details on what people are working on.

-Peff
