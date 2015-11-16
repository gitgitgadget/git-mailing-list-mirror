From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Mon, 16 Nov 2015 08:59:05 -0500
Message-ID: <20151116135905.GB13471@sigill.intra.peff.net>
References: <20151111143920.GA30409@musxeris015.imu.intel.com>
 <20151111144222.GA24717@musxeris015.imu.intel.com>
 <20151113061729.GC32157@sigill.intra.peff.net>
 <20151113093303.GA4111@musxeris015.imu.intel.com>
 <20151113232320.GB16173@sigill.intra.peff.net>
 <20151116080558.GA23851@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: junio@pobox.com, git@vger.kernel.org
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 15:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyKJN-000205-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 14:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbKPN7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 08:59:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:58097 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752093AbbKPN7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 08:59:08 -0500
Received: (qmail 21504 invoked by uid 102); 16 Nov 2015 13:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 07:59:07 -0600
Received: (qmail 12856 invoked by uid 107); 16 Nov 2015 13:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 08:59:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2015 08:59:05 -0500
Content-Disposition: inline
In-Reply-To: <20151116080558.GA23851@musxeris015.imu.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281341>

On Mon, Nov 16, 2015 at 09:05:58AM +0100, Clemens Buchacher wrote:

> Hi Junio,
> 
> I believe we have finalized the discussion on this patch. Please apply

Junio is out for a bit, and I'm acting as maintainer. I've picked up
your patch but haven't pushed anything out yet.

> No, I also cannot think of a good reason to keep it. Here is the patch
> with the test above removed.

Thanks, this looks good to me.

-Peff
