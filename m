From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 15:14:14 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmukm6.sf.sitaramc@sitaramc.homelinux.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
 <496F3C99.1040800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 16:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTwt-0006dh-Rr
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZAOPOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbZAOPOc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:14:32 -0500
Received: from main.gmane.org ([80.91.229.2]:48765 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbZAOPOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:14:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LNTvL-0003Y6-QK
	for git@vger.kernel.org; Thu, 15 Jan 2009 15:14:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 15:14:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 15:14:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105833>

On 2009-01-15, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Second, what result do you expect? If the merge is to be preserved then

I don't know.  I did this while trying to understand where
and how "-p" makes a difference.  If there's anything you
can point me to that explains rebase -p, especially from a
"here's where it comes useful" point of view, I'd appreciate
it.
