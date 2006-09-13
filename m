From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 23:54:23 +0200
Organization: At home
Message-ID: <ee9ult$mtn$1@sea.gmane.org>
References: <20060913210817.GA30782@spearce.org> <20060913211617.GJ23891@pasky.or.cz> <7v1wqf789j.fsf@assigned-by-dhcp.cox.net> <20060913215043.GE30782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 23:54:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcgr-0000YM-SN
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIMVyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWIMVyi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:54:38 -0400
Received: from main.gmane.org ([80.91.229.2]:47079 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751219AbWIMVyi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 17:54:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNcgd-0000V5-9I
	for git@vger.kernel.org; Wed, 13 Sep 2006 23:54:27 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:54:27 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:54:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26959>

Shawn Pearce wrote:

> But I don't really want this as a merge strategy in its own right.
> I want it as part of merge-recur (...)

Wouldn't it be better to have pluggable way to deal with conflicts,
be it diff3/merge with conflict markers, .rej files, or invoking
graphical merge tool (vimdiff, Emacs Emerge, xxdiff, Meld, KDiff3)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
