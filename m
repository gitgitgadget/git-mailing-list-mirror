From: Sam Ravnborg <sam@ravnborg.org>
Subject: gitweb - feature request
Date: Tue, 9 Aug 2005 21:31:04 +0200
Message-ID: <20050809193104.GA10858@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 09 21:29:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Zm7-0004aW-0J
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 21:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHIT2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 15:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVHIT2c
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 15:28:32 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:58503 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932192AbVHIT2c
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 15:28:32 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 59D5447FE3B;
	Tue,  9 Aug 2005 21:28:21 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 4C7446AC01D; Tue,  9 Aug 2005 21:31:04 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Kay.

When browsing http://www.kernel.org/git I often find myself looking for
the most recently changed tree.
For this it is very good that you have the "last change" in italic and
bolded if newer than a few hours (I think).

A nice additional feature would be the possibility to sort the output
according to last change, owner and description.
Using a click-able table heading would be the most intuitive way.

I have not looked into the source for gitweb, so I really do not know
how difficult this would be.


	Sam
