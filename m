From: James Purser <purserj@winnsw.com.au>
Subject: Re: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Tue, 14 Jun 2005 15:25:14 +1000
Message-ID: <1118726714.8712.22.camel@localhost.localdomain>
References: <1118713641.8712.10.camel@localhost.localdomain>
	 <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
Reply-To: purserj@winnsw.com.au
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 07:20:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di3qt-00058E-JM
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 07:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFNFZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 01:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFNFZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 01:25:29 -0400
Received: from [210.9.57.141] ([210.9.57.141]:56220 "EHLO mail.winnsw.com.au")
	by vger.kernel.org with ESMTP id S261180AbVFNFZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 01:25:25 -0400
Received: from RICOHPHOTO ([156.43.201.143])
        by mail.winnsw.com.au (WIN Server 1) with ESMTP id CPJ38469;
        Tue, 14 Jun 2005 15:24:39 +1000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One thing I would like to double check.

When running git commit I am told to run git-update-cache against the
files I want to commit. Would it be easier to have the git-commit-script
run this itself? Take out that second step and all that.
-- 
James Purser
Winnet Developer
+61 2 4223 4131
http://www.winnet.com.au

