From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/5] Some git-instaweb enhancements
Date: Wed, 26 Jul 2006 15:41:10 -0700
Message-ID: <20060726224110.GD31763@localdomain>
References: <Pine.LNX.4.63.0607261628020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jul 27 00:41:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5s43-0003WJ-8R
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 00:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWGZWlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWGZWlM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 18:41:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44704 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751779AbWGZWlM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 18:41:12 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C9F397DC023;
	Wed, 26 Jul 2006 15:41:10 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 26 Jul 2006 15:41:10 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607261628020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24257>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> these are assorted fixes/features for git-instaweb:
> 
> 1) do not mind git being installed somewhere else than /usr/bin
> 2) do not mind some Apache having mod_cgi builtin
> 3) store defaults in config
> 4) fall back to apache if lighttp cannot be found

1-4:

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
