From: Ran Shalit <ranshalit@gmail.com>
Subject: git gui - Linux
Date: Fri, 20 Jun 2014 12:30:44 +0300
Message-ID: <CAJ2oMh+3eOxrwg=L++H1FP94z=ypTWMUyCeJTQGqKL6cZYZ8gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 11:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxv9m-0003fV-1L
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 11:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965581AbaFTJaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 05:30:46 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:50686 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927AbaFTJap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 05:30:45 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so3279317qcv.12
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HRspdroFgeVH3fX31SVZE91auzczwbduOuBupBk63mA=;
        b=irGrA/Rj8+1Pg1RElStBgRzNlz6h8rpAyqc5iSkSAkbMUk2bG+OOBC1u0iSbvyZX2M
         GOV8zgnwPfI/AxXTPCQikezenj81Wq2VUZ99AaqTFwveNlq6d2avR7J6Rv0Y8NBF3nTA
         MdB95vqw41WOTai4qJhAcXqUdHsyF5v0Ntl/HGPPFRX5SWjiQgt4Qc2WhAdhvffyp+7s
         rnQdCYwE6j4KZD0JmX/2IGT/vo+Ao176bNWpXx1uOze4LYEFhJsqz0Q3M05ACms7jt7Z
         AOA/5DnmignyiBqUZyYnJRMASUXcWm8ZqIwDDos4PrYXmrCaLa0acYUNM6Z3R0bwTPx3
         i0Qg==
X-Received: by 10.140.107.182 with SMTP id h51mr2749023qgf.82.1403256644937;
 Fri, 20 Jun 2014 02:30:44 -0700 (PDT)
Received: by 10.224.125.131 with HTTP; Fri, 20 Jun 2014 02:30:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252222>

Hello,

I am trying to initialize remote git and push complete folder files
using git-gui. I'm Doing exactly the same sequence in windows with Git
Gui works perfectly.
But when doing remote->add in ubuntu, name: test Location: /home/ubuntu/test.git

I get the following error: fatal: GIT_WORK_TREE (or --work-tree=) not
allowed without specifying GIT_DIR (or --git-dir=) Should I set only
GIT_DIR=/home/ubuntu/test.git? And after doing that, repeat the
remote->add step giving the name and the same folder
/home/ubuntu/test.git again ?

Thanks, Ran
