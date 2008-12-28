From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: user manual question
Date: Sun, 28 Dec 2008 14:38:09 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
References: <gj7mmo$fvk$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 15:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGwo9-0007f6-T8
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 15:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbYL1OiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 09:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbYL1OiU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 09:38:20 -0500
Received: from main.gmane.org ([80.91.229.2]:60688 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbYL1OiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 09:38:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGwmX-0007pp-UJ
	for git@vger.kernel.org; Sun, 28 Dec 2008 14:38:17 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 14:38:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 14:38:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104051>

On 2008-12-28, Zorba <cr@altmore.co.uk> wrote:
> Under "Examining an old version without creating a new branch" subsection in 
> chapter1
>
> to aid my understanding, could the statement:
>
> "The HEAD then refers to the SHA1 of the commit instead of to a branch, and 
> git branch shows that you are no longer on a branch:"
>
> be restated more explicitly as:
>
> "The HEAD then refers to the SHA1 of the commit instead of to a branch head, 
> and git branch shows that you are no longer on a branch head:"

Sure, but I prefer "tip"; reduces confusion between "head"
and "HEAD" in spoken descriptions (I teach internal classes
on git occasionally, once even on a conf call!)

The git glossary makes no mention of "tip", so this is
probably "unblessed" :-)
