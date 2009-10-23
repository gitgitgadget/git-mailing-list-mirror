From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Thu, 22 Oct 2009 20:53:15 -0500
Message-ID: <20091023015315.GB10347@unpythonic.net>
References: <20091019195456.GA11121@unpythonic.net> <20091022195116.GB3944@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 03:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N19LQ-0004Sy-D7
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 03:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZJWBxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 21:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbZJWBxW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 21:53:22 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:40533 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbZJWBxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 21:53:22 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 2F75411456C; Thu, 22 Oct 2009 20:53:15 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20091022195116.GB3944@book.hvoigt.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131081>

On Thu, Oct 22, 2009 at 09:51:16PM +0200, Heiko Voigt wrote:
> Tested it and it works like a charm. I will include Shawn in the CC: so
> he can comment.

Thanks, but don't miss the v2 patch:
http://thread.gmane.org/gmane.comp.version-control.git/130968
this fixes a bug staging line(s) followed only by deletions.

Jeff
