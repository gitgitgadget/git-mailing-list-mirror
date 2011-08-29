From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 16:02:04 -0400
Message-ID: <20110829200204.GH756@sigill.intra.peff.net>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu>
 <7vty92adv0.fsf@alter.siamese.dyndns.org>
 <20110829185011.GC756@sigill.intra.peff.net>
 <4E5BEF47.5020608@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy829-0001D9-FG
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1H2UCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:02:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59119
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795Ab1H2UCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:02:07 -0400
Received: (qmail 19960 invoked by uid 107); 29 Aug 2011 20:02:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 16:02:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 16:02:04 -0400
Content-Disposition: inline
In-Reply-To: <4E5BEF47.5020608@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180336>

On Mon, Aug 29, 2011 at 09:57:59PM +0200, Johannes Sixt wrote:

> Am 29.08.2011 20:50, schrieb Jeff King:
> >      Have you considered publishing the
> >      tips of topic branches you apply?
> 
> Try 'git remote add github git://github.com/gitster/git' and drop your
> jaws on the wealth of branches you get on every 'git fetch github'.

Hmph. I had no idea that existed. Searching the list, it was mentioned
in a What's Cooking in May 2010.

-Peff
