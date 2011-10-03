From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 06:02:45 -0400
Message-ID: <20111003100245.GC16078@sigill.intra.peff.net>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <4E8975E7.2040804@viscovery.net>
 <m3d3eeo17l.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 12:02:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfML-00027a-BC
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 12:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab1JCKCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 06:02:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51527
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab1JCKCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 06:02:47 -0400
Received: (qmail 26836 invoked by uid 107); 3 Oct 2011 10:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 06:07:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 06:02:45 -0400
Content-Disposition: inline
In-Reply-To: <m3d3eeo17l.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182648>

On Mon, Oct 03, 2011 at 02:49:15AM -0700, Jakub Narebski wrote:

> I wonder if that is the case... but 48% responders of "Git User's
> Survey 2011" (3424 out of 7100 responders who answered queston 
> "23) How do you publish/propagate your changes?") answered that they
> use push via git protocol.
> 
> See https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL

I refuse to believe that 48% of people are using git:// to push. Surely
they are interpreting that response to overlap with "git over ssh" and
"git over http".

-Peff
