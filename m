From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-branch: display "was sha1" on branch deletion
	rather than just "sha1"
Date: Sun, 22 Mar 2009 02:13:20 -0400
Message-ID: <20090322061320.GB14765@coredump.intra.peff.net>
References: <ee63ef30903211709s24f8294dq9ea52bcae72b755a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlH2G-0003rR-Me
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZCVGN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 02:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZCVGNZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 02:13:25 -0400
Received: from peff.net ([208.65.91.99]:36597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZCVGNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 02:13:24 -0400
Received: (qmail 9708 invoked by uid 107); 22 Mar 2009 06:13:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 02:13:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 02:13:20 -0400
Content-Disposition: inline
In-Reply-To: <ee63ef30903211709s24f8294dq9ea52bcae72b755a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114123>

On Sat, Mar 21, 2009 at 07:09:17PM -0500, Brandon Casey wrote:

> Make it more pleasant to read about a branch deletion by adding "was".
> Jeff King suggested this, and I ignored it.  He was right.

Heh. While I am tempted to dance in a circle shouting "I told you so", I
actually find that after getting used to it, I do not mind the current
output. ;)

Out of curiosity, what prompted your change of heart? Did you hear from
somebody who found it confusing, or did you just change your mind?

-Peff
