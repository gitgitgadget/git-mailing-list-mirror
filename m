From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 14:18:08 -0500
Message-ID: <20090121191808.GF21686@coredump.intra.peff.net>
References: <200901211955.47362.markus.heidelberg@web.de> <1232564650-3701-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPibw-00063j-0l
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbZAUTSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbZAUTSL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:18:11 -0500
Received: from peff.net ([208.65.91.99]:39006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbZAUTSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:18:10 -0500
Received: (qmail 17033 invoked by uid 107); 21 Jan 2009 19:18:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:18:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:18:08 -0500
Content-Disposition: inline
In-Reply-To: <1232564650-3701-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106650>

On Wed, Jan 21, 2009 at 09:04:10PM +0200, Felipe Contreras wrote:

> This is shorter, avoids the burder to think about the format of the
> configuration file, and git config is already used in other places in
> the manual.

I seem to recall this coming up several times before, and there being a
sentiment that it was _good_ to introduce the user to concept of a
config file. It lets them know that it exists, approximately what the
syntax looks like, and demystifies what is going on when you type "git
config" (i.e., it intentionally shows that there is more than way to do
it).

I don't have a personal preference, but you may want to grep the
list archives for other discussion.

-Peff
