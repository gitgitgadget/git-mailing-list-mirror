From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/7] imap-send: use separate read and write fds
Date: Sat, 3 Oct 2009 05:40:49 -0400
Message-ID: <20091003094049.GA17873@coredump.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 11:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu191-0004JO-Dp
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 11:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZJCJkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZJCJkx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 05:40:53 -0400
Received: from peff.net ([208.65.91.99]:33774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754210AbZJCJkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 05:40:52 -0400
Received: (qmail 2699 invoked by uid 107); 3 Oct 2009 09:44:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 03 Oct 2009 05:44:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 05:40:49 -0400
Content-Disposition: inline
In-Reply-To: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129480>

On Sat, Oct 03, 2009 at 12:39:39AM +0000, Erik Faye-Lund wrote:

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

Why? Given its presence in this series, I can only assume it has to do
with windows portability, but it would be helpful to give a little bit
of the reasoning in the commit message.

-Peff
