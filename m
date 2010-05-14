From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: Field with abbreviated objectname
Date: Fri, 14 May 2010 01:12:57 -0400
Message-ID: <20100514051257.GG6075@coredump.intra.peff.net>
References: <20100504110134.GA7947@coredump.intra.peff.net>
 <dc7a785c8051aa1f742b75c03ddd1fdba57272db.1273753841.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 14 07:13:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCnCt-0005kO-Ce
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 07:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0ENFND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 01:13:03 -0400
Received: from peff.net ([208.65.91.99]:38917 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332Ab0ENFNB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 01:13:01 -0400
Received: (qmail 28722 invoked by uid 107); 14 May 2010 05:13:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 01:13:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 01:12:57 -0400
Content-Disposition: inline
In-Reply-To: <dc7a785c8051aa1f742b75c03ddd1fdba57272db.1273753841.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147051>

On Thu, May 13, 2010 at 02:31:46PM +0200, Michael J Gruber wrote:

> Introduce a :short modifier to objectname which outputs the abbreviated
> object name.

Looks fine to me.

-Peff
