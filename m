From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-log: allow --decorate[=short|full]
Date: Tue, 18 Aug 2009 05:33:48 -0400
Message-ID: <20090818093348.GA3550@coredump.intra.peff.net>
References: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
 <20090815122812.GB30630@coredump.intra.peff.net>
 <8c5c35580908150723h6e4c8fcay43b708969a86ae27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdL4l-0005Qu-FI
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZHRJdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbZHRJdr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:33:47 -0400
Received: from peff.net ([208.65.91.99]:33175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbZHRJdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:33:46 -0400
Received: (qmail 9014 invoked by uid 107); 18 Aug 2009 09:33:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 Aug 2009 05:33:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 05:33:48 -0400
Content-Disposition: inline
In-Reply-To: <8c5c35580908150723h6e4c8fcay43b708969a86ae27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126360>

On Sat, Aug 15, 2009 at 04:23:12PM +0200, Lars Hjemli wrote:

> This patch introduces an extension to --decorate to allow the caller to
> specify either the short or the full versions.
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
> 
> Thanks for the review. I've adapted the patch to your comments, and
> modified the documentation of '--decorate' to be more specific.

Thanks. Looks good to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
