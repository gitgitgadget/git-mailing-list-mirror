From: Franck <vagabon.xyz@gmail.com>
Subject: Simple questions on GIT usage.
Date: Mon, 14 Nov 2005 16:46:23 +0100
Message-ID: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 14 16:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbgXM-0005Fe-3K
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 16:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKNPqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 10:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVKNPqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 10:46:25 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:42010 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751157AbVKNPqY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 10:46:24 -0500
Received: by zproxy.gmail.com with SMTP id 14so1303186nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 07:46:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CufeHObd1Tns9RFJbI2qGR0RBZXGDwp9ce5wEp3psbPNBfYngTSXB7zZGM592LV7rjtWxsks8o12n3JX2renE/RSMA8Rg3Z9istmU3KqyTAg8ATpXL1SBcrCxPLH/kQB6frezLpC1X3LKtXazc/bD296fm16l9KCHVluvEluinE=
Received: by 10.36.101.20 with SMTP id y20mr4266524nzb;
        Mon, 14 Nov 2005 07:46:24 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 07:46:23 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11804>

Hi,

I'd like to know how to delete an entire branch and all it's related
objects. Is the following correct to accomplish that ?

        # rm -f .git/refs/heads/mybranch
        # git-prune

And a second question is: how to get the tree ID of the working
repository ? I know it's very basic but I can't find out the answer in
any documentations.

Thanks
--
               Franck
