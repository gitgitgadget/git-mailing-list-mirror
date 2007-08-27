From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: gitweb and remote branches
Date: Tue, 28 Aug 2007 00:24:04 +0200
Message-ID: <favitd$3ff$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPn0J-0000q7-FC
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 00:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089AbXH0WYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 18:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXH0WYE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:24:04 -0400
Received: from main.gmane.org ([80.91.229.2]:37603 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757717AbXH0WYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 18:24:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPmzz-0004gj-1M
	for git@vger.kernel.org; Tue, 28 Aug 2007 00:23:55 +0200
Received: from host-62-10-78-152.cust-adsl.tiscali.it ([62.10.78.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 00:23:55 +0200
Received: from giuseppe.bilotta by host-62-10-78-152.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 00:23:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-62-10-78-152.cust-adsl.tiscali.it
User-Agent: KNode/0.10.5
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56888>

Hello all,

Currently, remote branch heads are only shown in the
shortlog, but I would like them to appear in the heads list,
together with the local branches. Is there some option for it?
I've browsed the gitweb source but I haven't found anything
that looked like it.

-- 
Giuseppe "Oblomov" Bilotta
