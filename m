From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments
	and w/o patch on stdin
Date: Wed, 28 Jan 2009 12:51:06 -0500
Message-ID: <20090128175106.GD8863@coredump.intra.peff.net>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com> <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, sverre@rabbelier.nl
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jan 28 18:52:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEaZ-00035a-Gj
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 18:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZA1RvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 12:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbZA1RvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 12:51:09 -0500
Received: from peff.net ([208.65.91.99]:40348 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbZA1RvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 12:51:08 -0500
Received: (qmail 24247 invoked by uid 107); 28 Jan 2009 17:51:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 12:51:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 12:51:06 -0500
Content-Disposition: inline
In-Reply-To: <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107553>

On Wed, Jan 28, 2009 at 04:18:30PM +0000, Pieter de Bie wrote:

> FWIW, I sometimes like to run 'git am', paste in a patch and hit ctrl-d.

I have to admit, I usually am opposed to this sort of terminal DWIMmery
for exactly that reason. But I don't personally ever cut and paste into
git-am, so I was trying not to raise a fuss. ;)

-Peff
