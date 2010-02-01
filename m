From: Jeff King <peff@peff.net>
Subject: Re: the workflow (from your POV) of managing git
Date: Mon, 1 Feb 2010 00:46:47 -0500
Message-ID: <20100201054647.GA7946@coredump.intra.peff.net>
References: <20375.1265000441@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:46:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbp7e-0003gB-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 06:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab0BAFqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 00:46:49 -0500
Received: from peff.net ([208.65.91.99]:53404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab0BAFqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 00:46:49 -0500
Received: (qmail 20851 invoked by uid 107); 1 Feb 2010 05:46:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 00:46:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 00:46:47 -0500
Content-Disposition: inline
In-Reply-To: <20375.1265000441@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138583>

On Sun, Jan 31, 2010 at 09:00:41PM -0800, layer wrote:

> Have you written anything up that tells people how you manage the git
> project?  Something that could be used by other project leaders?  I've
> been googling and haven't been able to find anything other than
> documents which describe the process from the other side (people
> submitting patches).

Try Documentation/howto/maintain-git.txt.

> could learn from by seeing a document on the process you use.  For
> example, do you have a script that generates the "what's cooking
> in..." emails?

Check out the 'todo' branch in git.git.

-Peff
