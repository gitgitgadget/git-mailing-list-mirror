From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Figured out how to get Mozilla into git
Date: Thu, 8 Jun 2006 22:17:00 -0400
Message-ID: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 09 04:17:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoWYd-000709-Ri
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 04:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWFICRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 22:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWFICRB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 22:17:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:40107 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751327AbWFICRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 22:17:00 -0400
Received: by nz-out-0102.google.com with SMTP id s18so950274nze
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 19:17:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F+XTojvmEloWAUq0TFZ7/A4Mcpf5wG3dSi4I/wstcRxUztDCB5o2rwNK/Fw3xRembBn1tnk42w2zaOjtZM/nrKmE+xZbmAfh6uDxwB4fPC/d8mtYIj1A91DoNFUl0LenLhY3rcu+Yt+d8deTEmBL60IfCHsFdHf8tW52gEp48cs=
Received: by 10.36.119.8 with SMTP id r8mr3242909nzc;
        Thu, 08 Jun 2006 19:17:00 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Thu, 8 Jun 2006 19:17:00 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21521>

I was able to import Mozilla into SVN without problem, it just occured
to me to then import the SVN repository in git. The import has been
running a few hours now and it is up to the year 2000 (starts in
1998). Since I haven't hit any errors yet it will probably finish ok.
I should have the results in the morning. I wonder how long it will
take to start gitk on a 10GB repository.

Once I get this monster into git, are there tools that will let me
keep it in sync with Mozilla CVS?
SVN renamed numeric branches to this form, unlabeled-3.7.24, so that
may be a problem.

Any advice on how to pack this to make it run faster?

-- 
Jon Smirl
jonsmirl@gmail.com
