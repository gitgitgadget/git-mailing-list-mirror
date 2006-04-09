From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] git-svnconvert: YASI (Yet Another SVN importer)
Date: Sun, 09 Apr 2006 18:43:53 +0200
Organization: At home
Message-ID: <e1bdjq$qf6$1@sea.gmane.org>
References: <20060409163426.GA22103@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Apr 09 18:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSd1L-00038y-PX
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 18:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWDIQn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 12:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDIQn5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 12:43:57 -0400
Received: from main.gmane.org ([80.91.229.2]:23429 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750781AbWDIQn4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 12:43:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FSd0u-00034k-Ca
	for git@vger.kernel.org; Sun, 09 Apr 2006 18:43:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 18:43:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 18:43:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18549>

Rutger Nijlunsing wrote:

> Since I didn't succeed in importing a (private) SVN repo into git, I
> wrote a new converter to handle more cases like:

Both git-svn[*1*] and git-svnimport failed? Have you tried Tailor tool:
  http://www.darcs.net/DarcsWiki/Tailor

>   - use command line svn instead of some perl library to have less
>     dependancies and to support proxy + repo authentification.
>     Might even work on MacOSX ;)

Instead adding dependence on Ruby, eh?


References
----------
[*1*] contrib/git-svn and http://git-svn.yhbt.net/
-- 
Jakub Narebski
Warsaw, Poland
