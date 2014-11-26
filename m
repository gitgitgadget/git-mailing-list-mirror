From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] pre-commit hook updates
Date: Tue, 25 Nov 2014 23:52:46 -0500
Message-ID: <20141126045246.GD15252@peff.net>
References: <cover.1416953772.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 05:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtUax-0008NX-H1
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 05:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbaKZEwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 23:52:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:45114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbaKZEwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 23:52:47 -0500
Received: (qmail 26581 invoked by uid 102); 26 Nov 2014 04:52:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 22:52:47 -0600
Received: (qmail 4218 invoked by uid 107); 26 Nov 2014 04:52:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 23:52:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 23:52:46 -0500
Content-Disposition: inline
In-Reply-To: <cover.1416953772.git.oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260271>

On Tue, Nov 25, 2014 at 11:51:27PM +0100, =C3=98ystein Walle wrote:

> I agree with Junio Hamano that it's better to provide no argument at =
all
> rather than an empty one. I also agree with Jeff King that "noamend" =
is
> better than an empty argument. I went with the second one since Jeff
> seemed to get the last word :)

I am not sure the last word counts for much. :) We'll see if Junio
responds (there, or to your patch). I do not feel _too_ strongly either
way, and I don't have much else to say besides what was said.

-Peff
