From: Jeff King <peff@peff.net>
Subject: Re: git remote rm non-existant-remote
Date: Mon, 29 Jun 2009 12:38:43 -0400
Message-ID: <20090629163842.GA12855@sigio.peff.net>
References: <540FF00B-9DE7-4C89-9EC3-264B5BDD9CDE@silverinsanity.com> <20090628161141.GA7796@sigio.peff.net> <C1DD7597-AAFF-4F79-B11C-4D6BE9EB2601@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJqm-0007FF-Oa
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZF2Qgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 12:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbZF2Qgt
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:36:49 -0400
Received: from peff.net ([208.65.91.99]:35693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbZF2Qgt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 12:36:49 -0400
Received: (qmail 12865 invoked by uid 1000); 29 Jun 2009 16:38:43 -0000
Content-Disposition: inline
In-Reply-To: <C1DD7597-AAFF-4F79-B11C-4D6BE9EB2601@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122448>

On Sun, Jun 28, 2009 at 07:04:17PM -0400, Brian Gernhardt wrote:

> >Ouch. That is indeed a serious bug. However, I can't reproduce with
> >current 'next'; which version of git are you using?
> 
> git version 1.6.3.3.467.g98a79
> 
> I believe that's the latest "next".

OK, then it is not a version problem, but rather I am doing something
different to try to reproduce it. Can you post a short set of commands
to show the problem?

-Peff
