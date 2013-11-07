From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Thu, 7 Nov 2013 14:19:44 -0800
Message-ID: <20131107221944.GA19238@sigill.intra.peff.net>
References: <527C0CEA.4020705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXva-000460-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3KGWTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:19:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:35215 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754123Ab3KGWTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:19:46 -0500
Received: (qmail 17801 invoked by uid 102); 7 Nov 2013 22:19:46 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Nov 2013 16:19:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Nov 2013 14:19:44 -0800
Content-Disposition: inline
In-Reply-To: <527C0CEA.4020705@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237441>

On Thu, Nov 07, 2013 at 09:58:02PM +0000, Ramsay Jones wrote:

> These patches fix various errors/warnings on the cygwin, MinGW and
> msvc builds, provoked by the jk/pack-bitmap branch.

Thanks. Your timing is impeccable, as I was just sitting down to
finalize the next re-roll. I'll add these in.

-Peff
