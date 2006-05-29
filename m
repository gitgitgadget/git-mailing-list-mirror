From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commands Mismatch in tutorial and the actual binaries.
Date: Mon, 29 May 2006 08:07:39 +0200
Organization: At home
Message-ID: <e5e33a$2up$1@sea.gmane.org>
References: <1148880611.7193.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 29 08:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkav1-00084s-WF
	for gcvg-git@gmane.org; Mon, 29 May 2006 08:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWE2GHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 02:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWE2GHs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 02:07:48 -0400
Received: from main.gmane.org ([80.91.229.2]:45263 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751222AbWE2GHr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 02:07:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fkaun-000832-VB
	for git@vger.kernel.org; Mon, 29 May 2006 08:07:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 08:07:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 08:07:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20923>

kandagatla.Srinivas wrote:

> Hi All 
> Im very new to GIT Stuff. But by installing the latest version (git-1.3.3)
> of GIT and going thru the tutorial, I am unable to understand why
> there is a mismatch in the commmands.
> Tutorial says use commands like git init-db but actually these are
> installed as git-init-db. Is this OK.. or NOT.
> 
> One more doubt is .. I was unable to locate a command like git-add ..
> 
> Can some one help me.

Actually, in properly installed git both versions should work, 
and 'git command' is preferred version, at least for the ordinary
user level commands; "plumbing" commands are usually spelled 'git-command'.
Usually 'git command' is just a wrapper calling git-command.

-- 
Jakub Narebski
Warsaw, Poland
