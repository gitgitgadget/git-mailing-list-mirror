From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: branch vs. cherry-pick workflow
Date: Wed, 8 Jul 2009 22:59:38 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh5a96q.95d.sitaramc@sitaramc.homelinux.net>
References: <24399128.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 01:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOg7M-0000x1-F6
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 01:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZGHW7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 18:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbZGHW7w
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 18:59:52 -0400
Received: from main.gmane.org ([80.91.229.2]:50984 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbZGHW7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 18:59:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MOg7C-0005MK-Ed
	for git@vger.kernel.org; Wed, 08 Jul 2009 22:59:50 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 22:59:50 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 22:59:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122925>

On 2009-07-08 20:51:38, jshalvi <jshalvi@gmail.com> wrote:
> It seems dangerous to rely on cherry-picking like this.  Are there any good
> technical reasons to insist on a branch/merge workflow as opposed to this
> commit/cherry-pick workflow?  It may sound like a simple question, but

man git-workflows and look at the section "MANAGING
BRANCHES" gives a very nice, though brief, overview of why
branching is better in general.

Regards,

Sitaram
