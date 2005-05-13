From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] mtkdiff 20050513
Date: Fri, 13 May 2005 22:56:36 +0900
Message-ID: <20050513135636.GA18960@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 13 15:49:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWaXD-0003C3-TX
	for gcvg-git@gmane.org; Fri, 13 May 2005 15:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVEMN4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVEMN4q
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 09:56:46 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:56093 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262371AbVEMN4n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 09:56:43 -0400
Received: by zproxy.gmail.com with SMTP id 16so1116864nzp
        for <git@vger.kernel.org>; Fri, 13 May 2005 06:56:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NmAqtZl9iKwpknUNjWvUFgrnpyxPvAKYF8key/CfiGkYCkk4VfwGwJBNo/OaFcDBZaifR68l6YzV+/OaRRE2gnP0PhJS0bDBGG4W1K7JyA7XZ+oxBgy9JBcX7IUV5Fih/rjGMlSVGduyjnj6axiO5jGQJox/45HM1czz+76SN6s=
Received: by 10.36.121.5 with SMTP id t5mr1035067nzc;
        Fri, 13 May 2005 06:56:41 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.103])
        by mx.gmail.com with ESMTP id 10sm1288768nzo.2005.05.13.06.56.40;
        Fri, 13 May 2005 06:56:41 -0700 (PDT)
Received: by htj.dyndns.org (Postfix, from userid 1000)
	id B0343184123; Fri, 13 May 2005 22:56:36 +0900 (KST)
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 Hello, guys.

 Here's mtkdiff 20050513.  Changes are

 * tarball name changed to mtkdiff from gitkdiff
 * gitkdiff modified to use the new git-* commands
 * gitkdiff no automtically locates git repository root, so you can
   execute it from any sub-directory.
 * quiltkdiff added.  It shows all the patches in the series with
   mtkdiff.
 * gitgrep added.  This isn't really related to mtkdiff or git, but
   I use it all the time and didn't wanna put it separately. :-)

 http://home-tj.org/mtkdiff/files/mtkdiff-20050513.tar.gz

 Thanks.

-- 
tejun
