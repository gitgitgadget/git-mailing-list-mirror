From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] Documentation/log: add a CONFIGURATION section
Date: Sun, 9 May 2010 02:57:10 -0400
Message-ID: <20100509065709.GB23717@sigill.intra.peff.net>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033040.GE7958@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 08:57:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB0Rx-0001lq-Iq
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 08:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab0EIG5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 02:57:12 -0400
Received: from peff.net ([208.65.91.99]:42647 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0EIG5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 02:57:12 -0400
Received: (qmail 17250 invoked by uid 107); 9 May 2010 06:57:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 09 May 2010 02:57:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 May 2010 02:57:10 -0400
Content-Disposition: inline
In-Reply-To: <20100509033040.GE7958@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146704>

On Sat, May 08, 2010 at 10:30:41PM -0500, Jonathan Nieder wrote:

> Add a configuration section summarizing variables that affect the
> log family of commands.

I think this is an improvement, but given this patch and the earlier
cut-and-paste of notes config into git-notes.txt, what do you think of
my proposal here:

  http://article.gmane.org/gmane.comp.version-control.git/145139
  [skip down to /You didn't mention configuration variables/]

I haven't actually started work on it yet, but it would simplify what
you're doing here.

-Peff
