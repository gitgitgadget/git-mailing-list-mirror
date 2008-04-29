From: Jeff King <peff@peff.net>
Subject: Re: reflog/show question
Date: Tue, 29 Apr 2008 19:07:15 -0400
Message-ID: <20080429230715.GB22598@sigill.intra.peff.net>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com> <20080428092410.GD16153@sigill.intra.peff.net> <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com> <20080429201214.GB20509@sigill.intra.peff.net> <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:08:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqyw8-0003tw-Ih
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYD2XHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYD2XHT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:07:19 -0400
Received: from peff.net ([208.65.91.99]:3157 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582AbYD2XHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:07:16 -0400
Received: (qmail 22959 invoked by uid 111); 29 Apr 2008 23:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 19:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 19:07:15 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80766>

On Wed, Apr 30, 2008 at 07:36:23AM +0930, Geoff Russell wrote:

> > Hmm. Are you sure that the commit you got from HEAD@{"3 minutes ago"}
> >  actually _has_ the file data/node/node.data? If it doesn't, then you get
> 
> Later today (touch wood) I'll prepare as small a test case as
> possible, then send
> a tar.gz of the .git directory. Okay?

That would be great, thanks.

-Peff
