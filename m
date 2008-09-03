From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Wed, 3 Sep 2008 08:47:52 -0400
Message-ID: <20080903124752.GA12936@coredump.intra.peff.net>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org> <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> <7vwshuglq1.fsf@gitster.siamese.dyndns.org> <7v3akigl1g.fsf@gitster.siamese.dyndns.org> <20080903001254.GA12263@coredump.intra.peff.net> <7v7i9udpmg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shd@modeemi.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 14:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Karnz-0005EM-EN
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 14:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYICMrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 08:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbYICMrz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 08:47:55 -0400
Received: from peff.net ([208.65.91.99]:3139 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbYICMrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 08:47:55 -0400
Received: (qmail 26794 invoked by uid 111); 3 Sep 2008 12:47:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 08:47:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 08:47:52 -0400
Content-Disposition: inline
In-Reply-To: <7v7i9udpmg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94791>

On Tue, Sep 02, 2008 at 05:44:55PM -0700, Junio C Hamano wrote:

> Perhaps "--dirstat-by-file" that implies "--dirstat" (with the
> understanding (and documentation) that "--dirstat" is a shorthand for
> "--dirstat-by-line" that does not exist)?

Makes sense to me.

-Peff
