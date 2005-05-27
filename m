From: Jonas Fonseca <fonseca@diku.dk>
Subject: [gitweb bug] Pressing commitdiff on first commit returns 403
Date: Sat, 28 May 2005 01:37:50 +0200
Message-ID: <20050527233750.GB25491@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 01:37:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DboMq-0005YE-BQ
	for gcvg-git@gmane.org; Sat, 28 May 2005 01:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVE0Xhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 19:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVE0Xhz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 19:37:55 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:25310 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262658AbVE0Xhw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 19:37:52 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 8E09A6E232C; Sat, 28 May 2005 01:37:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5CC8A6E2170; Sat, 28 May 2005 01:37:22 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0EF7A61FE0; Sat, 28 May 2005 01:37:51 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a minor issue. For example the URL below for the commitdiff of the
first git commit gives me ``403 Forbidden - Reading diff-tree failed.''

http://kernel.org/git/?p=git/git.git;a=commitdiff;h=e83c5163316f89bfbde7d9ab23ca2e25604af290

-- 
Jonas Fonseca
