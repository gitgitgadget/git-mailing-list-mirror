From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: problem using git on cygwin
Date: Mon, 30 Apr 2007 11:55:46 +0530
Message-ID: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 08:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiPKZ-0001P9-Hr
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 08:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423067AbXD3GZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 02:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423069AbXD3GZs
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 02:25:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:57302 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423067AbXD3GZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 02:25:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1446399wxd
        for <git@vger.kernel.org>; Sun, 29 Apr 2007 23:25:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uITZuWDNhqXEpvHraswz0wpLea9qFUJGksydiyftXBPGTrvWi1J3UGzSau54PC0DEbU2zx+uT25yxiha36KISzFEIqhkI58MaAJdMSll7qukPFNmRd6o22mbtwq9jXg+Uyh53yAv9DAK+9gi+TlNyFg6ucgaIemb17yjgzqmZ5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lc6L1ExzBYGM5SFlXPoqpp6Sy81mzFOTCC1D7Dbpkd7Trc50gZCvBDdJbz7TtD8J8KMVi5zHXGTr2Q2DhuGQkXyFuDEYiRRU5eM1UjFJV0+J+80g2vOFCSlk0HzAFQrNGL5W1mlioBU2P5meB5OEflyp27mt/6xGN3aXnb22J/0=
Received: by 10.100.13.12 with SMTP id 12mr3719064anm.1177914346726;
        Sun, 29 Apr 2007 23:25:46 -0700 (PDT)
Received: by 10.100.136.12 with HTTP; Sun, 29 Apr 2007 23:25:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45856>

Hi,

 Am completely new to git, and following from the tutorial, to use git
for my project.

 Using git version 1.5.0.3 on cygwin (available on packages).

I am able to do the steps.
1. git init on my source
2. git add .
3. git commit

After that, a new file is created for the project and after editing the file.
am trying to put into the souce.

since it is a new file for my project git repository, am trying to add it
but end up with errors as follows.


$ git add project/test.c
error: bad index file sha1 signature
fatal: index file corrupt

could you please help me, what am doing wrong?


best regards,
srinivas.
