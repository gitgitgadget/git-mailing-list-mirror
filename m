From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 07:55:26 -0800
Message-ID: <20051111155525.GD4051@reactrix.com>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de> <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de> <20051111150530.GT30496@pasky.or.cz> <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 16:59:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EabGF-00031w-Cj
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKKP4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKKP4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:56:16 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:35271 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750830AbVKKP4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 10:56:16 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jABFtcg8027276;
	Fri, 11 Nov 2005 07:55:38 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jABFtQZL027272;
	Fri, 11 Nov 2005 07:55:26 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11610>

On Fri, Nov 11, 2005 at 04:40:43PM +0100, Johannes Schindelin wrote:

> Note that the only symlink/symref you usually have is .git/HEAD. But it 
> feels wrong to take the worse approach in *all* cases, just because 
> *one* brain-fscked file system/operating system does not support the 
> superior approach.

Symlinks at the other end of an HTTP transport are also similarly
brain-challenged.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
