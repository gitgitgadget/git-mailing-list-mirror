From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/13] remote: new show output style
Date: Mon, 23 Feb 2009 01:46:15 -0500
Message-ID: <20090223064615.GB24517@coredump.intra.peff.net>
References: <cover.1235368324.git.jaysoffian@gmail.com> <904c2d8fe812fb5400d1b9946795c146de68eaca.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 07:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUbS-0001Tf-9z
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZBWGqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZBWGqS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:46:18 -0500
Received: from peff.net ([208.65.91.99]:59883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbZBWGqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:46:18 -0500
Received: (qmail 20979 invoked by uid 107); 23 Feb 2009 06:46:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 01:46:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 01:46:15 -0500
Content-Disposition: inline
In-Reply-To: <904c2d8fe812fb5400d1b9946795c146de68eaca.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111105>

On Mon, Feb 23, 2009 at 01:28:55AM -0500, Jay Soffian wrote:

> The existing output of "git remote show <remote>" is too verbose for the
> information it provides. This patch teaches it to provide more
> information in less space.
>
> Before the patch:
> [...]
> After this patch:
> [...]

Wow. IMHO, the new one is _way_ easier to read.

-Peff
