From: Jeff King <peff@peff.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 4 Jan 2008 16:07:51 -0500
Message-ID: <20080104210751.GB26248@coredump.intra.peff.net>
References: <1199426431-sup-6092@south> <20080104072650.GA24685@coredump.intra.peff.net> <1199471454-sup-4786@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtm9-0005Gr-43
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 22:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbYADVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 16:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYADVHy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 16:07:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbYADVHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 16:07:54 -0500
Received: (qmail 19548 invoked by uid 111); 4 Jan 2008 21:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 16:07:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 16:07:51 -0500
Content-Disposition: inline
In-Reply-To: <1199471454-sup-4786@south>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69607>

On Fri, Jan 04, 2008 at 10:31:03AM -0800, William Morgan wrote:

> > However, I'm not clear what advantages this has over "git add -p".
> 
> A better interface. (Where by "better", I mean, behaves how I personally
> prefer.)

OK. If it works for you, then I'm not one to say you shouldn't use it.
But if you have interface improvement suggestions for "git-add -i" or
"git-add -p", I'm sure they would be well-received (post-1.5.4 release,
of course).

-Peff
