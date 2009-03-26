From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Grammar fixes to "merge" and "patch-id" docs
Date: Wed, 25 Mar 2009 22:20:07 -0400
Message-ID: <20090326022006.GB5835@coredump.intra.peff.net>
References: <1238005422-7647-1-git-send-email-win@wincent.com> <7vocvp310v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 03:22:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmfEY-0006zn-ER
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 03:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbZCZCUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 22:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbZCZCUT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 22:20:19 -0400
Received: from peff.net ([208.65.91.99]:37796 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZCZCUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 22:20:18 -0400
Received: (qmail 10297 invoked by uid 107); 26 Mar 2009 02:20:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 22:20:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 22:20:07 -0400
Content-Disposition: inline
In-Reply-To: <7vocvp310v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114707>

On Wed, Mar 25, 2009 at 11:33:52AM -0700, Junio C Hamano wrote:

> Wincent Colaiuta <win@wincent.com> writes:
> 
> >  If you tried a merge which resulted in a complex conflicts and
> > -would want to start over, you can recover with 'git-reset'.
> > +want to start over, you can recover with 'git-reset'.
> 
> Reads Ok to me either way...

Wincent gave a more complete explanation, and I think he is right about
this change. But while reading this I also noticed "... a complex
conflicts ..." in the context line which should be just "complex
conflicts".

-Peff
