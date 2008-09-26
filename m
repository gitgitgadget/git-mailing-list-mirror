From: Jeff King <peff@peff.net>
Subject: Re: A note from the interim Git maintainer
Date: Fri, 26 Sep 2008 18:54:23 -0400
Message-ID: <20080926225423.GA25502@coredump.intra.peff.net>
References: <20080924154632.GR3669@spearce.org> <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:55:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjMDm-0001TD-Pa
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 00:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbYIZWy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYIZWy0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:54:26 -0400
Received: from peff.net ([208.65.91.99]:2311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbYIZWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:54:25 -0400
Received: (qmail 8753 invoked by uid 111); 26 Sep 2008 22:54:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 18:54:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 18:54:23 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96890>

On Fri, Sep 26, 2008 at 02:24:31PM +0100, Mike Ralphson wrote:

> Jeff, if you want to switch your BSD builds to Shawn's tree too, I
> made and pushed a tiny change to the gitbuild.sh script to allow for
> the spearce/{branch} format becoming spearce_{branch} in the tag
> names.

Thanks, that's a good idea. I'm building Shawn's master (on my todo is
adding the other branches, too, but I need to tweak my script or tweak
gitbuild.sh and switch to it).

-Peff
