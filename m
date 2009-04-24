From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diff: color statistics (stat, shortstat, numstat)
Date: Fri, 24 Apr 2009 18:26:35 -0400
Message-ID: <20090424222635.GA14604@coredump.intra.peff.net>
References: <200904222313.50081.markus.heidelberg@web.de> <1240610808-7285-2-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTtB-0004HR-ME
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZDXW0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZDXW0p
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:26:45 -0400
Received: from peff.net ([208.65.91.99]:51867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbZDXW0p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:26:45 -0400
Received: (qmail 32013 invoked by uid 107); 24 Apr 2009 22:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 18:26:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 18:26:35 -0400
Content-Disposition: inline
In-Reply-To: <1240610808-7285-2-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117503>

On Sat, Apr 25, 2009 at 12:06:48AM +0200, Markus Heidelberg wrote:

> numstat:
> Color added and removed lines per file.

Somehow I thought numstat was about being easy to parse for plumbing.
Are people really using it for human-readable output?

-Peff
