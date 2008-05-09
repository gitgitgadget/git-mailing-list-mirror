From: SungHyun Nam <goweol@gmail.com>
Subject: git pull/merge master on other branch
Date: Fri, 09 May 2008 14:26:46 +0900
Message-ID: <g00nb3$dlm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 07:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuL9G-0007rp-Ja
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 07:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763468AbYEIF1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 01:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762987AbYEIF1N
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 01:27:13 -0400
Received: from main.gmane.org ([80.91.229.2]:39485 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760538AbYEIF1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 01:27:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JuL8O-0005tU-D7
	for git@vger.kernel.org; Fri, 09 May 2008 05:27:09 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 05:27:08 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 05:27:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81601>

Hello,

If I am on a branch (reguarly rebased), I don't want to switch to
master branch, but merge origin into master.
If I switch to master and pull and switch to branch, I have to
rebuild almost of sources.

How I can pull origin into master without switching to master
branch?

Thanks,
namsh
