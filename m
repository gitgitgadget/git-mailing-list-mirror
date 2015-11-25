From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Documentation/git-update-index: add missing opts to
 synopsys
Date: Wed, 25 Nov 2015 04:03:05 -0500
Message-ID: <20151125090305.GB4696@sigill.intra.peff.net>
References: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:03:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Vys-0005Ph-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbbKYJDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:03:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:33748 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754143AbbKYJDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:03:08 -0500
Received: (qmail 27945 invoked by uid 102); 25 Nov 2015 09:03:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 03:03:07 -0600
Received: (qmail 24269 invoked by uid 107); 25 Nov 2015 09:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:03:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 04:03:05 -0500
Content-Disposition: inline
In-Reply-To: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281687>

On Wed, Nov 25, 2015 at 07:53:12AM +0100, Christian Couder wrote:

> Untracked cache and split index related options should appear
> in the 'SYNOPSIS' section.
> 
> These options are already documented in the 'OPTIONS' section.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Soon after sending the first version I realized that the split index
> options were not in the synopsys either...

Sorry, too late. I merged v1 as part of yesterday's cycle, as it seemed
obviously correct (that's what I get... :) ).

Can you please send the change as a patch on top?

-Peff
