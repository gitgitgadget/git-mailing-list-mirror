From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Fri, 21 Jun 2013 02:40:49 -0400
Message-ID: <20130621064049.GA29922@sigill.intra.peff.net>
References: <1371586006-16289-1-git-send-email-artagnon@gmail.com>
 <7vip1b40zb.fsf@alter.siamese.dyndns.org>
 <CALkWK0=6ot9ZXEyMmO1ZtEXPi5H1JXXvG5j6yvBeE56H9zQBwg@mail.gmail.com>
 <20130621053112.GA9634@sigill.intra.peff.net>
 <CALkWK0ky+zYk+7s8yK6VeA+2xyQ41TfoREym2jq3L77q5MTpzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 08:41:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upv1m-0007fo-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 08:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439Ab3FUGky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 02:40:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35689 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161436Ab3FUGkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 02:40:53 -0400
Received: (qmail 19248 invoked by uid 102); 21 Jun 2013 06:41:53 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 01:41:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 02:40:49 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0ky+zYk+7s8yK6VeA+2xyQ41TfoREym2jq3L77q5MTpzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228578>

On Fri, Jun 21, 2013 at 12:07:50PM +0530, Ramkumar Ramachandra wrote:

> Yesterday's jc publish fixed it: 6c473a5 (build: generate and clean
> test scripts, 2013-06-07) graduated to master; it adds $NO_INSTALL to
> the target "all", among other things.

Ah, makes sense. Sorry to be slow.

-Peff
