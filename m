From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Tue, 4 Nov 2008 00:20:24 -0500
Message-ID: <20081104052024.GE31276@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <20081103092507.GD13930@artemis.corp> <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 06:21:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxEMG-0002NA-Tk
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 06:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbYKDFU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 00:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbYKDFU1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 00:20:27 -0500
Received: from peff.net ([208.65.91.99]:1606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbYKDFU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 00:20:26 -0500
Received: (qmail 5264 invoked by uid 111); 4 Nov 2008 05:20:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 00:20:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 00:20:24 -0500
Content-Disposition: inline
In-Reply-To: <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100039>

On Mon, Nov 03, 2008 at 03:33:10PM -0800, Junio C Hamano wrote:

> By the way, didn't we add a feature to let you say "git push $there :"
> which is to do what "git push --matching $there" would do?

Oh, indeed: a83619d (add special "matching refs" refspec) from April.
So given that, I think my arguments for "--matching" are pointless.

-Peff
