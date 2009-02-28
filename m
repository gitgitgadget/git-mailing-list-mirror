From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] git remote: set-head and new show output (UPDATED)
Date: Sat, 28 Feb 2009 01:33:22 -0500
Message-ID: <20090228063322.GA6775@coredump.intra.peff.net>
References: <cover.1235546707.git.jaysoffian@gmail.com> <cover.1235759631.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 07:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdImm-0001p3-5J
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 07:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbZB1Gd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 01:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZB1Gd0
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 01:33:26 -0500
Received: from peff.net ([208.65.91.99]:52322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbZB1Gd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 01:33:26 -0500
Received: (qmail 17637 invoked by uid 107); 28 Feb 2009 06:33:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 01:33:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 01:33:22 -0500
Content-Disposition: inline
In-Reply-To: <cover.1235759631.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111750>

On Fri, Feb 27, 2009 at 02:10:03PM -0500, Jay Soffian wrote:

> I didn't want to resend the whole series (gmane 111394), so what I did was
> create a new patch which comes after patch 7 in that series. Call it patch 7a.
> The rest of that series is then identical (modulo line number offsets in
> patches touching remote.c) except for patches 8 and 19. Patches 7a, and the
> new 8 and 19 follow this email.

These look good to me.

-Peff
