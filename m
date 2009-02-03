From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: Git -> SVN importing
Date: Tue, 03 Feb 2009 10:39:55 -0500
Message-ID: <4988654B.1080903@thewritingpot.com>
References: <c115fd3c0902030717u6a8f3bbck3027cf74715c79a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 16:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNP3-0001ze-8p
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZBCPkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbZBCPkG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:40:06 -0500
Received: from main.gmane.org ([80.91.229.2]:54948 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbZBCPkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:40:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUNNc-00062J-Tn
	for git@vger.kernel.org; Tue, 03 Feb 2009 15:40:04 +0000
Received: from compton-two-sixty-eight.mit.edu ([18.109.6.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 15:40:04 +0000
Received: from edwardzyang by compton-two-sixty-eight.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 15:40:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: compton-two-sixty-eight.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <c115fd3c0902030717u6a8f3bbck3027cf74715c79a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108201>

Tim Visher wrote:
> I figured that someone would have to have done this before since
> git-svn is so magical.  However, I thought I'd ask.

You want to look at git svn dcommit.
