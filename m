From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 19:41:43 +0100
Message-ID: <20100217184142.GD2251@book.hvoigt.net>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhor0-0003VP-RY
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 19:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab0BQSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 13:41:47 -0500
Received: from darksea.de ([83.133.111.250]:52280 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753768Ab0BQSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 13:41:46 -0500
Received: (qmail 22167 invoked from network); 17 Feb 2010 19:41:43 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2010 19:41:43 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140244>

On Wed, Feb 17, 2010 at 12:39:52PM +1300, Steven Drake wrote:
> This alows the 'git-log --decorate' to be enabled by default so that normal
> log outout contains ant ref names of commits that are shown.

I implemented the same option once but discarded the patch because of
issues with gitk. If it is enabled you can not use gitk anymore thats
why it was not useful to me because I switch between the two tools
regularly.

Maybe you have an idea how to avoid this?

cheers Heiko
