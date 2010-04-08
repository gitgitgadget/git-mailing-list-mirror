From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Thu, 8 Apr 2010 02:44:50 -0400
Message-ID: <20100408064450.GE30473@coredump.intra.peff.net>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
 <1270661327-28078-1-git-send-email-avarab@gmail.com>
 <7vfx37cckf.fsf@alter.siamese.dyndns.org>
 <7vbpduc333.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:45:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlUL-0007IL-03
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127Ab0DHGpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:45:12 -0400
Received: from peff.net ([208.65.91.99]:41315 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299Ab0DHGpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:45:11 -0400
Received: (qmail 16830 invoked by uid 107); 8 Apr 2010 06:45:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 02:45:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 02:44:50 -0400
Content-Disposition: inline
In-Reply-To: <7vbpduc333.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144328>

On Wed, Apr 07, 2010 at 03:25:36PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not think Jeff was against having a complete listing in the
> > documentation.  Wasn't his suggestion about "git commit -h" output?
> 
> I'll amend the earlier "allow-empty-message" one from you to cover this
> topic.

My suggestion was for "git commit -h", and your amended patch addresses
it. Thanks.

For the record, I am _also_ against having a complete listing at the
header of the documentation, but last time this was discussed some
others felt differently, and I don't think we reached a consensus on
what the manpages should look like (right now some have a very terse
synopsis, and some try to list every option).

-Peff
