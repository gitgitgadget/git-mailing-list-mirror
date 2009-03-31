From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add configuration variable for sign-off to format-patch
Date: Tue, 31 Mar 2009 16:04:57 -0400
Message-ID: <20090331200457.GA23879@coredump.intra.peff.net>
References: <20090331185018.GD72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokEM-0000bM-EP
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbZCaUFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbZCaUFL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:05:11 -0400
Received: from peff.net ([208.65.91.99]:45501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbZCaUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:05:10 -0400
Received: (qmail 12764 invoked by uid 107); 31 Mar 2009 20:05:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 16:05:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 16:04:57 -0400
Content-Disposition: inline
In-Reply-To: <20090331185018.GD72569@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115306>

On Tue, Mar 31, 2009 at 08:50:19PM +0200, Heiko Voigt wrote:

> If you regularly create patches which require a Signed-off: line you may
> want to make it your default to add that line. It also helps you not to forget
> to add the -s/--signoff switch.

I personally have no problem with such an option, but it has been argued
against before. E.g.:

  http://article.gmane.org/gmane.comp.version-control.git/32522
  http://article.gmane.org/gmane.comp.version-control.git/51780

There is also some discussion here indicating that it might be accepted:

  http://article.gmane.org/gmane.comp.version-control.git/103939

-Peff
