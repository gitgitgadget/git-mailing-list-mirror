From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 13:56:51 -0400
Message-ID: <20160429175651.GA30765@sigill.intra.peff.net>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
 <20160429062357.12647-2-computersforpeace@gmail.com>
 <20160429141212.GB26643@sigill.intra.peff.net>
 <20160429155532.GA57118@google.com>
 <xmqqfuu4z4pr.fsf@gitster.mtv.corp.google.com>
 <20160429174958.GA30593@sigill.intra.peff.net>
 <xmqq7ffgz4ej.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:57:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCex-0002tp-TR
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbcD2R44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:56:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbcD2R4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:56:55 -0400
Received: (qmail 20545 invoked by uid 102); 29 Apr 2016 17:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 13:56:54 -0400
Received: (qmail 24435 invoked by uid 107); 29 Apr 2016 17:56:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 13:56:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 13:56:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7ffgz4ej.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293038>

On Fri, Apr 29, 2016 at 10:55:00AM -0700, Junio C Hamano wrote:

> Thanks.  Perhaps squash this to the patch in the message you are
> responding to.
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ff7eaaf..786e0fa 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> [...]

Yeah, this (and the rest of the plan you outlined) all look good to me.
Thanks.

-Peff
