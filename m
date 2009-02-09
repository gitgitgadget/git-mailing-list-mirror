From: Jeff King <peff@peff.net>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Mon, 9 Feb 2009 13:36:23 -0500
Message-ID: <20090209183623.GA27255@coredump.intra.peff.net>
References: <20090207162754.5fb8b63f@perceptron> <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com> <20090208011802.2b7b9e74@perceptron> <7v1vu91d00.fsf@gitster.siamese.dyndns.org> <20090208111838.GD14359@coredump.intra.peff.net> <7v8wogzr3v.fsf@gitster.siamese.dyndns.org> <20090209182843.GA27109@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWb0z-0001db-MQ
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZBISg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZBISg0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:36:26 -0500
Received: from peff.net ([208.65.91.99]:37716 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbZBISgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:36:25 -0500
Received: (qmail 4179 invoked by uid 107); 9 Feb 2009 18:36:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 13:36:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 13:36:23 -0500
Content-Disposition: inline
In-Reply-To: <20090209182843.GA27109@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109099>

On Mon, Feb 09, 2009 at 01:28:43PM -0500, Jeff King wrote:

> Here are two reasons why we might not want to conflate the two safety
> valves:

Argh, sorry, I'm an idiot. For some reason when I saw
"receive.denyDeleteCurrent" I read "receive.denyCurrentBranch" (and if
you look carefully in the thread, I even _typed_ it wrong, too!).

So I read your emails as "we should put this new safety valve under the
same option as the other one" which you are of course not proposing at
all.

Please disregard this last email (and the one before it, but you have
already responded to that ;) ). And I will ask a doctor to remove the brain
tumor that is clearly inhibiting my reading comprehension.

-Peff
