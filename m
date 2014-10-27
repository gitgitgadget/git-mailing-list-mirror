From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Followup patches for Asciidoctor
Date: Sun, 26 Oct 2014 22:07:43 -0700
Message-ID: <20141027050742.GA2996@peff.net>
References: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XicXR-00061q-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 06:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbaJ0FHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 01:07:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:33952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbaJ0FHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 01:07:46 -0400
Received: (qmail 329 invoked by uid 102); 27 Oct 2014 05:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 00:07:46 -0500
Received: (qmail 2789 invoked by uid 107); 27 Oct 2014 05:07:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 01:07:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 22:07:43 -0700
Content-Disposition: inline
In-Reply-To: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 12:13:41AM +0000, brian m. carlson wrote:

> I did note Peff's suggestion to add a macro to enable the use of
> Asciidoctor, but I want to defer that until a later point.  There isn't
> a released version of Asciidoctor with the necessary changes and I'd
> like to avoid confusing users by making them think it will work when it
> probably won't.

Thanks for considering it; your analysis makes sense to me.

-Peff
