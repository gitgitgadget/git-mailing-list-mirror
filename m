From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] git-svn: pass tests on svn trunk
Date: Fri, 21 Sep 2007 01:27:24 -0700
Message-ID: <20070921082724.GB5152@mayonaise>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Sep 21 10:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYdrH-0003Ad-Gu
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 10:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbXIUI10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbXIUI10
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 04:27:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54448 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbXIUI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 04:27:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CC93C7DC029;
	Fri, 21 Sep 2007 01:27:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 21 Sep 2007 01:27:24 -0700
Content-Disposition: inline
In-Reply-To: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58834>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> While svn trunk is a dubious target to integrate with, perhaps these
> patches will prove useful to include anyway.
> 
> Tested against svn 1.4.2 and svn trunk r26724

Fine by me, as what's in trunk will likely be in a released version some
day and I'm glad that people are already testing git-svn against it.

This series Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
