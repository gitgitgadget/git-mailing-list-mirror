From: Martin Coxall <quasi@cream.org>
Subject: Packing on kernel.org
Date: Sat, 1 Oct 2005 10:02:38 +0100
Message-ID: <068ea79fc648433faa44a6d4cc287614@cream.org>
References: <Pine.LNX.4.64.0509302320560.3378@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 01 11:03:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELdGq-0000Oj-G7
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 11:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJAJCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 05:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVJAJCq
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 05:02:46 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:30736 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750780AbVJAJCq
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 05:02:46 -0400
Received: from [192.168.0.4] (unknown [84.12.75.244])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 3C178250448
	for <git@vger.kernel.org>; Sat,  1 Oct 2005 10:02:38 +0100 (BST)
In-Reply-To: <Pine.LNX.4.64.0509302320560.3378@g5.osdl.org>
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9594>

Was there an cron process or kernel.org that should be repacking the 
public repositories periodically?

The git/cogito/sparse/linux-2.6 repositories all now have several 
thousand unpacked objects a piece, and it takes so long to do an http 
clone it's not even funny.

Martin
