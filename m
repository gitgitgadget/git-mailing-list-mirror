From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 19:27:56 -0400
Message-ID: <20110912232756.GD28994@sigill.intra.peff.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vty8h2wda.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fv1-00048b-TF
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab1ILX17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:27:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54796
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848Ab1ILX16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:27:58 -0400
Received: (qmail 20363 invoked by uid 107); 12 Sep 2011 23:28:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 19:28:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 19:27:56 -0400
Content-Disposition: inline
In-Reply-To: <7vty8h2wda.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181257>

On Mon, Sep 12, 2011 at 02:51:48PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > [Stalled]
> >
> > * jk/add-i-hunk-filter (2011-07-27) 5 commits
> >   (merged to 'next' on 2011-08-11 at 8ff9a56)
> >  + add--interactive: add option to autosplit hunks
> >  + add--interactive: allow negatation of hunk filters

Hmph. After seeing this in WC for weeks, I just now noticed the typo
in the patch subject.

> >  + add--interactive: allow hunk filtering on command line
> >  + add--interactive: factor out regex error handling
> >  + add--interactive: refactor patch mode argument processing
> 
> Could you start thinking about completing this series, or posting a "where
> to go next" summary to guide others with lessor git clout to finish with
> help from people who know "add -i" codepath better (I could help), once
> 1.7.7 ships?

I was really just doing this to help scratch Duy's itch. Do other people
actually find it useful? I sort of imagined he would pick up the patches
and post them as part of a series once he had something working. I
suspect until then, you could just drop them.

-Peff
