From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 02:53:49 -0400
Message-ID: <20160420065349.GA14490@sigill.intra.peff.net>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
 <a7b889d525f99fecfb9d4a890fd2a5d4bf3001e0.1461134258.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asm1O-0002eJ-6O
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 08:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbcDTGxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 02:53:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:52699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752813AbcDTGxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 02:53:53 -0400
Received: (qmail 26252 invoked by uid 102); 20 Apr 2016 06:53:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 02:53:52 -0400
Received: (qmail 28050 invoked by uid 107); 20 Apr 2016 06:53:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 02:53:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 02:53:49 -0400
Content-Disposition: inline
In-Reply-To: <a7b889d525f99fecfb9d4a890fd2a5d4bf3001e0.1461134258.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291987>

On Wed, Apr 20, 2016 at 08:38:03AM +0200, Johannes Schindelin wrote:

> We simply need to read the config, is all.
> 
> This fixes https://github.com/git-for-windows/git/issues/733
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Looks good to me. Thanks.

-Peff
