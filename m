From: Chris Wright <chrisw@redhat.com>
Subject: Re: git-svn name
Date: Mon, 27 Mar 2006 09:48:24 -0800
Message-ID: <20060327174824.GT15997@sorel.sous-sol.org>
References: <20060326030425.GA6306@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Gerrit Pape <pape@smarden.org>,
	Chris Wright <chrisw@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 27 19:47:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNvoX-0003d4-AG
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 19:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWC0Rrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 12:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWC0Rrd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 12:47:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62594 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750905AbWC0Rrd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 12:47:33 -0500
Received: from sorel.sous-sol.org (localhost.localdomain [127.0.0.1])
	by sorel.sous-sol.org (8.13.6/8.13.1) with ESMTP id k2RHmSYZ000771;
	Mon, 27 Mar 2006 09:48:29 -0800
Received: (from chrisw@localhost)
	by sorel.sous-sol.org (8.13.6/8.13.6/Submit) id k2RHmOYj000739;
	Mon, 27 Mar 2006 09:48:24 -0800
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060326030425.GA6306@hand.yhbt.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18085>

* Eric Wong (normalperson@yhbt.net) wrote:
> Would distro package maintainers also be willing to add my git-svn
> script to their git-svn binary packages when a new release of git is
> made, too?  It's quite different from git-svnimport (see
> contrib/git-svn/git-svn.txt for details).

I think your script name is fine.  Best way to handle this is with a
patch to make your git-svn part of the git-svn packaging.

thanks,
-chris
