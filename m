From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 15:29:52 +0200
Message-ID: <20060706132951.G5731ccca@leonov.stosberg.net>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 15:30:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyTvh-0001Xp-ED
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 15:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWGFN37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 09:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWGFN37
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 09:29:59 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:29148 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030263AbWGFN37 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 09:29:59 -0400
Received: from leonov.stosberg.net (p213.54.86.66.tisdip.tiscali.de [213.54.86.66])
	by ncs.stosberg.net (Postfix) with ESMTP id 7ECD0AEBA004;
	Thu,  6 Jul 2006 15:29:47 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 2B421103C18; Thu,  6 Jul 2006 15:29:52 +0200 (CEST)
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060706161011.ccc2ea1c.tihirvon@gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23388>

Timo Hirvonen wrote:

> "which" isn't portable. On SunOS 5.9 "which foo" prints error message to
> stdout and returns 0.  I use this in my own configure scripts:

Yes, you're right and that function looks fine.  I will resend the
patches later, but I'll wait a few hours for further comments.

Regards,
Dennis
