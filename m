From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 04:51:31 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp21uj.i22.sitaramc@sitaramc.homelinux.net>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 05:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWkcU-0007tx-3j
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 05:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZBJEvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 23:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbZBJEvo
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 23:51:44 -0500
Received: from main.gmane.org ([80.91.229.2]:36547 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbZBJEvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 23:51:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWkax-00046t-KL
	for git@vger.kernel.org; Tue, 10 Feb 2009 04:51:39 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 04:51:39 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 04:51:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109179>

On 2009-02-09, Brandon Casey <casey@nrlssc.navy.mil> wrote:

> Not sure if I'd use this snapshot tool, but per-branch stash would
> probably be useful.  If stashes were per-branch, then it would probably
> be pretty easy to build this snapshot tool on top of it.

I use cross-branch stashes all the time.  Stash it here, go
there, and pop the stash.  I hope that does not change :-)
