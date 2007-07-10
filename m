From: "satish madrage" <svmdcv@gmail.com>
Subject: mirroring between svn and git
Date: Tue, 10 Jul 2007 12:55:04 +0530
Message-ID: <6a9b0ede0707100025w2a37eecr8bb06e537523a003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8A5y-0004dA-4D
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 09:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXGJHZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 03:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbXGJHZG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 03:25:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:59094 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXGJHZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 03:25:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1734970wah
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 00:25:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ovLWFm6bnsKosVZL7c9HD4fvJ53YQrEDusK0jP6UpH1kWknkt1TBGMfwll7bK7u/7qBaCLOVgqOISlLcRmwcCFtP9JkIaHuUjjfruO3YSDh5pb40Dn0LS7Wv67XPiL5NL9EQaZAFECnkF/Yc0Yw0KQiYfSf3B1F1InLaVfviMto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V2AIl5lWTd1nOaypcufHvAJDdxCvFVDbxCRxLLfFYnCB1xHnMER81nplZ7fgHTf4/xLmbGohY58y7WuYepvHQL66fz5NP4jY8YNLvJvHdqPJ5u+zB5HqfVYQW7wu1isv+wqLDHh0jnyA4OpX4dnyvKba/O8m1xeKahy2mAwkrO4=
Received: by 10.114.93.17 with SMTP id q17mr3908531wab.1184052304644;
        Tue, 10 Jul 2007 00:25:04 -0700 (PDT)
Received: by 10.114.126.5 with HTTP; Tue, 10 Jul 2007 00:25:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52050>

list,

i am totally new to git, we use svn, and we are working on open source
tool which tests linux kernel.

now we are contributing to one more open source project which is under git.
we use svn, now i need to mirror between git and svn,

can somebody give pointers to any docs through which i can set up
mirroring between svn and git. (i.e all svn checked in contenst shd be
seen in git).

Thanks in advance,

Satish.
