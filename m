From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 2 Dec 2015 19:07:05 -0500
Message-ID: <20151203000705.GA22067@sigill.intra.peff.net>
References: <20151202002450.GA27994@sigill.intra.peff.net>
 <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
 <20151202223114.GA20542@sigill.intra.peff.net>
 <xmqqoae84eci.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 01:07:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HQc-0006EK-B0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbbLCAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:07:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:36594 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757795AbbLCAHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:07:08 -0500
Received: (qmail 22848 invoked by uid 102); 3 Dec 2015 00:07:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 18:07:08 -0600
Received: (qmail 5396 invoked by uid 107); 3 Dec 2015 00:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 19:07:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 19:07:05 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoae84eci.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281922>

On Wed, Dec 02, 2015 at 03:31:41PM -0800, Junio C Hamano wrote:

> I just finished my first pass of going through "cook -w" output and
> had trouble judging jk/send-email-ssl-errors topic, which is marked
> as "waiting for re-roll", but I cannot seem to find any discussion
> on it, just the original patch $gmane/281655.  Are there concerns?

Looks like it needs a slight tweak:

  http://article.gmane.org/gmane.comp.version-control.git/281693

-Peff
