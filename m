From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Some issues with current qgit on exit ( aka "Crash this!" )
Date: Sat, 9 Sep 2006 01:03:52 +0200
Message-ID: <e5bfff550609081603s2fb1be98gdafb91681a4aeaae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 01:04:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLpO9-0005tH-Br
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIHXDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWIHXDx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 19:03:53 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:42962 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751228AbWIHXDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 19:03:52 -0400
Received: by py-out-1112.google.com with SMTP id n25so1009498pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 16:03:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gyOja4NaCb+RoQu79rpUW+9s5QAciMF3s9Z4wcCS8NLZqBBhgkH5OTofvQqiIeiolphdr3YQhVU77+U9Nxls2TenV+Att1u7rY2Oboz3Gy9l7LyKpOuKFGwIaIZVakCh2JXsx2onajhKUbBcUWC9Kbs076pm3N9mHOFxK9QxDlM=
Received: by 10.35.46.11 with SMTP id y11mr3815002pyj;
        Fri, 08 Sep 2006 16:03:52 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 8 Sep 2006 16:03:52 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26723>

>
> > I was planning (well, still I am) to release new version this week
> > end, and your bug report is arrived just in time ;-)
>
> I tried to push qgit a bit harder, and it's still easy to crash:
>

Thanks for reporting, bug (a subtle one this time) fixed and patch pushed.

I don't think you or someone else could crash qgit anymore ;-)

Thanks
Marco
