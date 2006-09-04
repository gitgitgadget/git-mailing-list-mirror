From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Mon, 04 Sep 2006 20:34:06 +0200
Organization: At home
Message-ID: <edhrij$l9j$1@sea.gmane.org>
References: <200609041810.09838.jnareb@gmail.com> <200609041813.49103.jnareb@gmail.com> <200609042032.13742.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 04 20:34:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKJHF-00007p-Cq
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWIDSe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWIDSe3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 14:34:29 -0400
Received: from main.gmane.org ([80.91.229.2]:2740 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964972AbWIDSe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 14:34:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKJGz-0008WA-DG
	for git@vger.kernel.org; Mon, 04 Sep 2006 20:34:17 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 20:34:17 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 20:34:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26430>

Jakub Narebski wrote:

> index 199fbe87384cd3f4686916277dd124cefc751e8a..f3b762de92e579300eba3f53ee26b2a80b4e76c7 100644

Hmmm... I do wonder why --binary implies --full-index option.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
