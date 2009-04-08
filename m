From: Jeff King <peff@peff.net>
Subject: Re: Any way to edit the file in index directly?
Date: Tue, 7 Apr 2009 22:16:20 -0400
Message-ID: <20090408021620.GC18244@coredump.intra.peff.net>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com> <20090408021041.GB18244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNMS-0005KM-VU
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687AbZDHCQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757253AbZDHCQY
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:16:24 -0400
Received: from peff.net ([208.65.91.99]:35424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZDHCQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:16:24 -0400
Received: (qmail 11690 invoked by uid 107); 8 Apr 2009 02:16:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 22:16:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 22:16:20 -0400
Content-Disposition: inline
In-Reply-To: <20090408021041.GB18244@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116020>

On Tue, Apr 07, 2009 at 10:10:41PM -0400, Jeff King wrote:

> On Wed, Apr 08, 2009 at 09:03:03AM +0800, Ping Yin wrote:
> 
> > There seems to be a patch for this ( add -e?), but i forget where to
> > find it.
> 
> "add -p" has an "e"dit option for editing the patch. I don't recall any
> way of directly editing the content.

Hmm, actually maybe you are thinking of:

  http://article.gmane.org/gmane.comp.version-control.git/103389

which I even reviewed, but it doesn't seem to have gone anywhere after
that.

-Peff
