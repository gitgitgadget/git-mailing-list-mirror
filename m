From: Jeff King <peff@peff.net>
Subject: Re: Make author and committer available to pre-commit hook
Date: Tue, 6 Jul 2010 03:29:47 -0400
Message-ID: <20100706072947.GB3567@sigill.intra.peff.net>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
 <20100705114619.GA21146@sigill.intra.peff.net>
 <AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
 <AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
 <7vocel5n08.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Gisle Aas <gisle@aas.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 09:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW2bY-0004iJ-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab0GFH3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 03:29:50 -0400
Received: from peff.net ([208.65.91.99]:45463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171Ab0GFH3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 03:29:49 -0400
Received: (qmail 25338 invoked by uid 107); 6 Jul 2010 07:30:46 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 06 Jul 2010 03:30:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jul 2010 03:29:47 -0400
Content-Disposition: inline
In-Reply-To: <7vocel5n08.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150332>

On Mon, Jul 05, 2010 at 08:04:39PM -0700, Junio C Hamano wrote:

> I wonder if we should also make author/committer dates available via the
> same mechanism.

I don't see why not. It is a trivial amount of code, and I can see at
least author date being useful.

-Peff
