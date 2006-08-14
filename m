From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/9] gitweb: Great subroutine renaming + task separation into subroutines + improvements
Date: Mon, 14 Aug 2006 12:40:20 +0200
Organization: At home
Message-ID: <ebpjt8$5ao$1@sea.gmane.org>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZrM-00069B-CS
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWHNKjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWHNKjt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:39:49 -0400
Received: from main.gmane.org ([80.91.229.2]:9879 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751985AbWHNKjs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 06:39:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCZrF-00067o-DX
	for git@vger.kernel.org; Mon, 14 Aug 2006 12:39:45 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 12:39:45 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 12:39:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25347>

Jakub Narebski wrote:

> This series of patches is based on the 'next' branch, commit
> 10a6653c818f78c6032d45e1d4da544085e1f28b (v1.4.2-g10a6653)

But it rebases without problem on top of current master
  460cccd3ba1d38fd64c9e83e40d58bcf3e9d7d2c (v1.4.2-g460cccd)
('git rebase --onto master next' rebases without errors)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
