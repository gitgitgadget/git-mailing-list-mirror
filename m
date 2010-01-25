From: Jeff King <peff@peff.net>
Subject: Re: basic question about push
Date: Mon, 25 Jan 2010 06:00:23 -0500
Message-ID: <20100125110023.GA8517@coredump.intra.peff.net>
References: <loom.20100124T074722-510@post.gmane.org>
 <20100124081513.GA10700@coredump.intra.peff.net>
 <7vzl43723t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russ Paielli <Russ.Paielli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:00:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMgJ-0003dH-Oq
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab0AYLA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565Ab0AYLA0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:00:26 -0500
Received: from peff.net ([208.65.91.99]:38679 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab0AYLA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 06:00:26 -0500
Received: (qmail 6179 invoked by uid 107); 25 Jan 2010 11:05:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 Jan 2010 06:05:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2010 06:00:23 -0500
Content-Disposition: inline
In-Reply-To: <7vzl43723t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137949>

On Sun, Jan 24, 2010 at 11:08:06AM -0800, Junio C Hamano wrote:

> >   http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch
> 
> I saw somebody referred to this entry and refused to study the entry
> immediately after seeing the word "firewalled", saying "my environment is
> not firewalled", without trying to judge if the description applies to his
> case.  This was understandable; the workflow will apply in non-firewalled
> case just as well, even though "firewalled" case may be the easiest to see
> why it is recommended.
> 
> Perhaps the title of the entry needs to be rewritten to clarify that this
> is not _limited_ to a firewalled situation?

I agree, and just tweaked the title and text a bit. After doing that, I
realized that you had already done so a few hours ago, too. :) So
between the two of us, hopefully it is better.

-Peff
