From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2011, #03; Fri, 6)
Date: Fri, 6 May 2011 21:46:34 -0400
Message-ID: <20110507014634.GB25771@sigill.intra.peff.net>
References: <7v7ha3xvm1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 03:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIWbg-0006pN-7o
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 03:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1EGBqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 21:46:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34663
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab1EGBqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 21:46:37 -0400
Received: (qmail 15396 invoked by uid 107); 7 May 2011 01:48:32 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 21:48:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 21:46:34 -0400
Content-Disposition: inline
In-Reply-To: <7v7ha3xvm1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173031>

On Fri, May 06, 2011 at 04:22:30PM -0700, Junio C Hamano wrote:

> * jk/merge-one-file-working-tree (2011-04-29) 2 commits
>   (merged to 'next' on 2011-05-02 at 308fe21)
>  + merge-one-file: fix broken merges with alternate work trees
>  + add tests for merge-index / merge-one-file

Hmm, I expected this to end up on maint. Is it worth cherry-picking
(it cleanly applies to maint)?

-Peff
