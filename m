From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] test suite: add a check that all test numbers are
 unique
Date: Fri, 21 Aug 2009 10:37:00 -0400
Message-ID: <20090821143700.GA6850@coredump.intra.peff.net>
References: <4A8E68AF.8040001@viscovery.net>
 <20090821125324.GA6280@coredump.intra.peff.net>
 <4A8E9D73.1090604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeVEr-0002I1-KD
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 16:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbZHUOg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbZHUOg7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 10:36:59 -0400
Received: from peff.net ([208.65.91.99]:34279 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbZHUOg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 10:36:58 -0400
Received: (qmail 1441 invoked by uid 107); 21 Aug 2009 14:37:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 21 Aug 2009 10:37:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2009 10:37:00 -0400
Content-Disposition: inline
In-Reply-To: <4A8E9D73.1090604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126727>

On Fri, Aug 21, 2009 at 03:13:23PM +0200, Johannes Sixt wrote:

> Because it's faster on Windows ;-) No, seriously, I didn't know about
> uniq -d.

:)

> Here is a replacement patch.

Looks good to me. Thanks.

-Peff
