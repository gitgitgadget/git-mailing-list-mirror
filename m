From: Gelonida N <gelonida@gmail.com>
Subject: git alias and --help
Date: Fri, 28 Oct 2011 00:20:56 +0200
Message-ID: <j8clg9$ldh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 00:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYK4-0007CE-01
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab1J0WVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 18:21:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:41827 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab1J0WVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 18:21:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJYJx-00079p-LF
	for git@vger.kernel.org; Fri, 28 Oct 2011 00:21:09 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 00:21:09 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 00:21:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184324>

I'm having a tiny question about git aliases.

in ~/.gitconfig I defined an alias

b = branch



This works well execp if I type


git b --help

Now I get the output
`git b' is aliased to `branch'


which is nice to know however what I reall wanted is to get the helptext
for the branch command.


Is there any trick to get the help text of git branch without
having to type

git branch --help
