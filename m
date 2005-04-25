From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: git add / update-cache --add fails.
Date: Mon, 25 Apr 2005 22:26:00 +0100
Message-ID: <200504252226.00354.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 23:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQB5M-00022M-33
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDYV1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVDYV0e
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:26:34 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:57188 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261222AbVDYV0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 17:26:06 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp002.mail.ukl.yahoo.com with SMTP; 25 Apr 2005 21:26:01 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DQB5c-0003M2-Sq
	for git@vger.kernel.org; Mon, 25 Apr 2005 22:26:00 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello people,

I get these errors when trying to add a new file to the directory.  I pulled 
the latest version today, and the day before yesterdays version had the same 
problem (using git-pasky)

rhys@metatron:~/repo/learning.repo$ update-cache --add w1d4p1.c
fatal: Unable to add w1d4p1.c to database
rhys@metatron:~/repo/learning.repo$ git add w1d4p1.c
fatal: Unable to add w1d4p1.c to database
rhys@metatron:~/repo/learning.repo$  

Any ideas?

Rhys


