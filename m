From: Ram Rachum <ram@rachum.com>
Subject: git cascade and git forward-merge
Date: Tue, 01 Apr 2014 13:41:37 +0300
Message-ID: <533A97E1.5080806@rachum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 12:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUw93-0007v3-RH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 12:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaDAKmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 06:42:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60874 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaDAKmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 06:42:10 -0400
Received: by mail-wi0-f178.google.com with SMTP id bs8so4851232wib.11
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=A9rTZRSlAiWBnh35YPUF7Xzytgus0rIiFWl+ZAV5eW8=;
        b=Afdy3ZjdGkKvk0kIUkJ5eLf11CGSr3DEtWv7WE4ShdMFrJsUZJsLmOUAbG+uvHXX6E
         IR9m+xM3ChpViKQJRhfm1fx9OjY3BkQFf8jMqVu3RcomcixDbOYqKIxFZJMo+AvFP4TF
         z7pv6dA27dslsXoWGDOEshPGFwoLowffbLWy8fFHCIj9KvJbInmGI0VjjK37crICPdb7
         dh2ZIxEbkytFOS0jYdLQoV/YD/rJ0iHNNwz/c5sU46xPpqm/HsAaABCh7Q2lDuy0i3oS
         GcAAXhT+ZXzyflX/TdTgquLsAlSSGfs0F3CQ4+kFXbwf9SGAx0mXAHva46JLR8xTS9mW
         4ZeA==
X-Received: by 10.180.149.240 with SMTP id ud16mr12464379wib.23.1396348929361;
        Tue, 01 Apr 2014 03:42:09 -0700 (PDT)
Received: from [192.168.1.100] ([5.144.63.243])
        by mx.google.com with ESMTPSA id q49sm39637331eem.34.2014.04.01.03.42.05
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 03:42:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245579>

Hi guys!

I just made two Git scripts of mine open-source:

https://github.com/cool-RR/git-cascade 
<https://github.com/cool-RR/git-cascade>

This project contains two scripts:

  - git cascade - Cascade changes from each branch to its dependents.
  - git forward-merge - Merge branches without checking them out.

Click the GitHub link above to read all about them.


Thanks,
Ram.
