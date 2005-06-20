From: Wayne Scott <wsc9tt@gmail.com>
Subject: How did this odd merge happen?
Date: Mon, 20 Jun 2005 10:09:44 -0500
Message-ID: <59a6e583050620080947aea144@mail.gmail.com>
Reply-To: Wayne Scott <wsc9tt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jun 20 17:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkNoo-0003VZ-3V
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 17:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFTPJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFTPJz
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 11:09:55 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:15592 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261322AbVFTPJo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 11:09:44 -0400
Received: by wproxy.gmail.com with SMTP id 68so735314wri
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 08:09:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i2xaZXEclXRrYSxpuwz96KaiOChSMa3TwOXerzDbM9kdDLXDfJ3IRRpI3ItjRZ1Ur5kw4p3Oeg9aOaQ3MenV25sXIkiU/mJ621Uv4GGOXJqL/8vkjri/EM1NCPlQ/gOTq1iSrWnvJzKVAHAB5jTLozBdBZZYO7QbrkBDl0fleE4=
Received: by 10.54.106.2 with SMTP id e2mr2717293wrc;
        Mon, 20 Jun 2005 08:09:44 -0700 (PDT)
Received: by 10.54.36.54 with HTTP; Mon, 20 Jun 2005 08:09:44 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

$ git-cat-file commit  13e652800d1644dfedcd0d59ac95ef0beb7f3165
tree 6cdd9771bd9a56de1b0246a330ccd916ecdb1d41
parent 4332bdd332a2dca93dc3b1d017b2dd27d5c8cef3
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author David Woodhouse <dwmw2@shinybook.infradead.org> 1115555034 +0100
committer David Woodhouse <dwmw2@shinybook.infradead.org> 1115555034 +0100

Merge with master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


-Wayne
