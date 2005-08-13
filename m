From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCHSET] Cogito documentation updates
Date: Sat, 13 Aug 2005 18:23:52 +0200
Message-ID: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:24:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ync-0000AD-BP
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVHMQXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVHMQXy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:23:54 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:8666 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751351AbVHMQXx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:23:53 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 90CF06E1489; Sat, 13 Aug 2005 18:23:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5F76F6E11D3; Sat, 13 Aug 2005 18:23:40 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 74A2260A44; Sat, 13 Aug 2005 18:23:52 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patchset contains the following 5 patches:

  [PATCH 1/5] Also install cg-*.txt files
  [PATCH 2/5] Add SEE ALSO section to cogito(7) which mentions git(7)
  [PATCH 3/5] Generate Documentation/introduction.html from the README file
  [PATCH 4/5] Add more AsciiDoc markup to the README file
  [PATCH 5/5] Ignore patch backup files (*.{orig,rej}) when finding cg-* manpage scripts

-- 
Jonas Fonseca
