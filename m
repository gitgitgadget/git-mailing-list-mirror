From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 03:03:30 +0200
Message-ID: <20080605010330.GB24466@leksak.fem-net>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain> <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jaroslav Kysela <perex@perex.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 03:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K43u9-0006hl-GW
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 03:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYFEBDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 21:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbYFEBDh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 21:03:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:56279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752788AbYFEBDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 21:03:36 -0400
Received: (qmail invoked by alias); 05 Jun 2008 01:03:34 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp023) with SMTP; 05 Jun 2008 03:03:34 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/OaRUV/Q7OEeAARK/DjDce/rI4FZTWvjavj9VpG2
	rH+Dy3s6eRkR3A
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K43t4-0006qP-91; Thu, 05 Jun 2008 03:03:30 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806041641150.13507@racer.site.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83842>

Hi,

> - as has been pointed out several times now, you _are_ the committer, and 
>   you seem to want to lie there.

Lying is already possible with GIT_COMMITTER_{NAME,EMAIL,NAME} environment
variables. Of course, this is only used for testing purposes and to interact 
with other SCMs. And I don't think there are more use cases, but perhaps I
am (or we all are) missing some fact ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
