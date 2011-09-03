From: DaveAbrahams <dave@boostpro.com>
Subject: Re: [BUG] git-svn: --no-metadata related bug
Date: Sat, 3 Sep 2011 00:01:09 -0700 (PDT)
Message-ID: <1315033269582-6756044.post@n2.nabble.com>
References: <20110405190722.GB25644@kytes> <4D9C64EB.5060703@drmicha.warpmail.net> <20110406181234.GB667@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 09:01:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzkE8-00037r-JG
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 09:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1ICHBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 03:01:12 -0400
Received: from sam.nabble.com ([216.139.236.26]:49309 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab1ICHBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 03:01:09 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dave@boostpro.com>)
	id 1QzkE1-0007DJ-JC
	for git@vger.kernel.org; Sat, 03 Sep 2011 00:01:09 -0700
In-Reply-To: <20110406181234.GB667@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180644>

I am reproducing the problem here.  Unfortunately I can't share the
repository with you but I'm willing to try debugging it a bit.

--
View this message in context: http://git.661346.n2.nabble.com/BUG-git-svn-no-metadata-related-bug-tp6243475p6756044.html
Sent from the git mailing list archive at Nabble.com.
