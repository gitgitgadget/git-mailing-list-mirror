From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] feature request: git-mergetool --force
Date: Sat, 18 Oct 2008 16:54:43 -0400
Message-ID: <20081018205443.GA29534@coredump.intra.peff.net>
References: <48F91E59.50202@gmail.com> <20081018154824.GA20185@coredump.intra.peff.net> <48FA2E9F.3090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 22:56:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIqN-0002l9-9k
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYJRUyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 16:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYJRUyq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:54:46 -0400
Received: from peff.net ([208.65.91.99]:1076 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbYJRUyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 16:54:45 -0400
Received: (qmail 3679 invoked by uid 111); 18 Oct 2008 20:54:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 18 Oct 2008 16:54:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2008 16:54:43 -0400
Content-Disposition: inline
In-Reply-To: <48FA2E9F.3090305@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98572>

On Sat, Oct 18, 2008 at 07:44:47PM +0100, William Pursell wrote:

>> Something like --no-prompt makes more sense to me, though probably
>> something a little easier to type would be nice (or maybe alias "-n").
>
> Actually, perhaps an "interactive=no" configuration setting,
> which might imply trustExitCode = true.

That sounds reasonable to me.

-Peff
