From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Tue, 8 Dec 2009 01:29:37 -0500
Message-ID: <20091208062937.GA11353@coredump.intra.peff.net>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
 <20091207210608.6117@nanako3.lavabit.com>
 <7vein635vn.fsf@alter.siamese.dyndns.org>
 <20091208055735.GA9951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHtZz-0000Zj-KE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935831AbZLHG3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 01:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935828AbZLHG3e
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:29:34 -0500
Received: from peff.net ([208.65.91.99]:45550 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932682AbZLHG3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 01:29:34 -0500
Received: (qmail 8470 invoked by uid 107); 8 Dec 2009 06:34:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 01:34:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 01:29:37 -0500
Content-Disposition: inline
In-Reply-To: <20091208055735.GA9951@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134823>

On Tue, Dec 08, 2009 at 12:57:35AM -0500, Jeff King wrote:

> On Mon, Dec 07, 2009 at 12:07:24PM -0800, Junio C Hamano wrote:
> 
> > I haven't asked people why they choose to write like this:
> > 
> > 	char* string;
> > 
> > beyond "that is how we were taught and what we are used to".
> 
> I have seen it in C++ code and recommended many years ago on
> comp.lang.c++. The argument was something along the lines of:

Perhaps I should have simply used google:

  http://www2.research.att.com/~bs/bs_faq2.html#whitespace

-Peff
