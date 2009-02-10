From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5400: allow individual tests to fail
Date: Tue, 10 Feb 2009 07:01:07 -0500
Message-ID: <20090210120107.GA15491@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <20090209184625.GA27037@coredump.intra.peff.net> <7v4oz3v36a.fsf@gitster.siamese.dyndns.org> <7vab8vthlj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrK0-00015e-RQ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZBJMBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZBJMBK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:01:10 -0500
Received: from peff.net ([208.65.91.99]:60509 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbZBJMBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:01:09 -0500
Received: (qmail 13098 invoked by uid 107); 10 Feb 2009 12:01:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 07:01:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 07:01:07 -0500
Content-Disposition: inline
In-Reply-To: <7vab8vthlj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109219>

On Mon, Feb 09, 2009 at 01:39:52PM -0800, Junio C Hamano wrote:

> > Will reroll if I have the time but it is likely that I may be tending
> > other topics first.
> 
> -- >8 --
> Subject: [PATCH] Modernize t5400 test script

Much nicer, thanks.

-Peff
