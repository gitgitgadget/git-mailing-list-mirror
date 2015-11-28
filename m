From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8] Add Travis CI support
Date: Sat, 28 Nov 2015 12:12:23 -0500
Message-ID: <20151128171223.GD27264@sigill.intra.peff.net>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 18:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2j2w-0000Wj-CO
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbK1RM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 12:12:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:34695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbbK1RM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 12:12:26 -0500
Received: (qmail 19729 invoked by uid 102); 28 Nov 2015 17:12:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:12:25 -0600
Received: (qmail 23576 invoked by uid 107); 28 Nov 2015 17:12:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 12:12:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 12:12:23 -0500
Content-Disposition: inline
In-Reply-To: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281792>

On Fri, Nov 27, 2015 at 10:23:26AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> diff to v7:
> * remove NO_GETTEXT patch and install gettext on OS X to compile with
>   no additional flags (thanks Torsten)
> * fix P4 version (15.2 is the latest one available)

Thanks. I don't have any other comments on this one. I guess the next
step is for me to get git/git signed up for Travis, and then merging
this to 'master' will have the desired effect.

-Peff
