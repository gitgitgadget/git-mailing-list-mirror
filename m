From: Jeff King <peff@peff.net>
Subject: Re: situation codes (e.g. #16) in unpack-trees.c
Date: Wed, 12 Aug 2009 17:07:27 -0400
Message-ID: <20090812210726.GA16640@coredump.intra.peff.net>
References: <bb6059c00908121405t4f34c50eo532b928fa6d6f89c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff Enderwick <jeff.enderwick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbL2l-0002XT-7E
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 23:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbZHLVHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZHLVHZ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 17:07:25 -0400
Received: from peff.net ([208.65.91.99]:58760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbZHLVHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 17:07:25 -0400
Received: (qmail 13719 invoked by uid 107); 12 Aug 2009 21:07:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 Aug 2009 17:07:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2009 17:07:27 -0400
Content-Disposition: inline
In-Reply-To: <bb6059c00908121405t4f34c50eo532b928fa6d6f89c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125748>

On Wed, Aug 12, 2009 at 02:05:06PM -0700, Jeff Enderwick wrote:

> Newbie here. I'm trying to grok git's merge algorithms. Where are
> those '#' codes written up (e.g. #16, #5ALT, etc)?
> Is there a write-up anywhere on the merge logic?

Try Documentation/technical/trivial-merge.txt.

-Peff
