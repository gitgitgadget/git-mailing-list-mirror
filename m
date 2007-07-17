From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:16:07 +0200
Message-ID: <20070717161607.GD16209@cip.informatik.uni-erlangen.de>
References: <469CE836.6010508@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApig-0003vu-PL
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbXGQQQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758740AbXGQQQK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:16:10 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49843 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755146AbXGQQQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 12:16:09 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 221673F42C; Tue, 17 Jul 2007 18:16:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469CE836.6010508@arcom.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52770>

Hello,

> # git --version
> git version 0.99.8.GIT

this doesn't match

> '# dpkg -l | grep git' shows ' git-core 1:1.5.2.3-1'

that. Maybe you should build your own git packages. Lucky you that it is
pretty easy with debian. Have a look at this thread:

	http://groups.google.com/group/linux.kernel/browse_thread/thread/b8509269407c0fdc/d05d0547e7dfcf03?lnk=st&q=author%3AThomas+author%3AGlanzmann+git+linux.kernel&rnum=1#d05d0547e7dfcf03

especially the first post (scroll up).

	Thomas
