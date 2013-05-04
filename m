From: Norah Jones <nh.jones01@gmail.com>
Subject: How do I modify the commit message (not the topmost one)  of a git commit?
Date: Sat, 4 May 2013 06:31:26 +0000
Message-ID: <abcd1234abc123ab12a0000000345000020000004001@gmail.com>
Reply-To: Norah Jones <nh.jones01@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 08:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYW0X-0006qu-TI
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 08:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab3EDGba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 02:31:30 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38204 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab3EDGb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 02:31:29 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so1244266pdj.35
        for <git@vger.kernel.org>; Fri, 03 May 2013 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:to:from:reply-to:subject:message-id:x-priority
         :x-mailer:mime-version:content-transfer-encoding:content-type;
        bh=M/fnPJcZASl1YqtKppkNn8HW1ts6DE83FySnIa17nvU=;
        b=PLsZq1SZIKV0gSXq0PqcHVhFVLaetfIAE+G8SdOlQrh5FHU5H6lBiPO6Bar9vfCCGC
         djSeiNfaYEOIqB2dWZ1ZwNlTGHXdwSAYBxtgEwWPPlPXsIIzQ8zyp+PEY3EYF+S7JkrB
         YRdX9Jd7oQzGGXEpSQSddG3CkIsHl4RBDsCHWxQNHT7G1BMYzLLuIVJ3v1CNgMxR/3FQ
         AzDBcFS5E1O0gmvzuZJ+GErCzzDC0n/68oRjlR9VVbn4bCALPsYUJYdTEYZvfA+lJywF
         E/AjEnXjja0W6Z1/g2buXKPpHyw0tI/LZ3lqewfNK/cImtb/o7hh8O4ZBbZjZJt2vd6W
         VLgQ==
X-Received: by 10.68.233.3 with SMTP id ts3mr17269010pbc.153.1367649088689;
        Fri, 03 May 2013 23:31:28 -0700 (PDT)
Received: from www.queryhome.com (ec2-54-245-79-134.us-west-2.compute.amazonaws.com. [54.245.79.134])
        by mx.google.com with ESMTPSA id qi1sm15940070pac.21.2013.05.03.23.31.27
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 23:31:27 -0700 (PDT)
X-Priority: 3
X-Mailer: CatPHPMailer 5.1 (phpmailer.sourceforge.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223355>

Hi, 

I did a series of commits and now I find one of my commit (not the topmost one) has an incorrect commit message. How can I change that specific one? I believe "git commit --amend" works only for the last commit.


Thanks,
Norah Jones
