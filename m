From: Kay Sievers <kay.sievers@suse.de>
Subject: Re: do people use the 'git' command?
Date: Fri, 10 Jun 2005 20:59:45 +0200
Message-ID: <20050610185945.GB13102@vrfy.org>
References: <E1DgodI-0003ov-Fl@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 20:55:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgofH-0003kr-5S
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 20:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFJS7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFJS7r
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 14:59:47 -0400
Received: from soundwarez.org ([217.160.171.123]:59860 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261172AbVFJS7q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 14:59:46 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 646123F733; Fri, 10 Jun 2005 20:59:45 +0200 (CEST)
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1DgodI-0003ov-Fl@highlab.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2005 at 12:53:32PM -0600, Sebastian Kuzminsky wrote:
> What good is the 'git' command?  It's a shortcut to run the
> "git-$FUNCTION-script" programs, but it doesnt do the "git-$FUNCTION"
> programs.  It just doesnt seem worth its inode, to me.  And it doesnt seem
> worth the pain to distribution maintainers (like me) to avoid the naming
> conflict with GNU Interactive Tools' /usr/bin/git.

Well, drop the GNU Interactive Tools instead. We've removed it from the
SuSE packages and have a "real" git package now. :)

Kay
