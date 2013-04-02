From: =?ISO-8859-1?Q?Gauthier_=D6stervall?= <gauthier@ostervall.se>
Subject: Re: [PATCH] gitk: Move hard-coded colors to .gitk
Date: Tue, 2 Apr 2013 10:41:51 +0200
Message-ID: <CAM8gEgihLehkNSfaKGuxO6Spc=vxF7UAZmWwiTNpXXSjMjVzcA@mail.gmail.com>
References: <1364391651-5896-1-git-send-email-gauthier@ostervall.se> <CALkWK0mt1cZ22xXFXywQNk7EnZ22kq0KJfbr-GTrSg6iMXF5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, paulus <paulus@samba.org>,
	patthoyts <patthoyts@users.sourceforge.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 10:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMwoB-00050S-3j
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 10:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761411Ab3DBImj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 04:42:39 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:41000 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761097Ab3DBImN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 04:42:13 -0400
Received: by mail-we0-f175.google.com with SMTP id t11so135052wey.34
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 01:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-originating-ip:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type:x-gm-message-state;
        bh=FVjv6pDnJVN6kMfPBI/JRr4kR1EzP5fig4p1kfxxfPE=;
        b=MccpX41PoH3c22HOHd1HbU2AEEwf1ycG2+bc2Qt3t9VyDdTPvX/2THREfhcwuGHbue
         fqy52xaPn/2k2DsMAKolYQhGxrKp6W33huLqo4yMLGtAk05DZyu/TDFr4I7AGFCiA4qq
         qtusIlbzkWSRWagmUZRbmnp6uDeRm5TuKz4km+GiQoJGEl5T3Ebn72zjejYo+FW+vuil
         VF5dOmBuEo6Glz4PSf5yPnV29JjXBXfk/ND2IVrlxqqS3/ld5EEixbMrZEZ00b9uJjaB
         WFd1cBzYDueXzg1WzI3l2i8zUK+ldcPVcPjv3flaAc2ROIg0cVhfZXNTJ6l1MSPf8Pvz
         POtg==
X-Received: by 10.194.81.40 with SMTP id w8mr19903278wjx.14.1364892132486;
 Tue, 02 Apr 2013 01:42:12 -0700 (PDT)
Received: by 10.180.125.15 with HTTP; Tue, 2 Apr 2013 01:41:51 -0700 (PDT)
X-Originating-IP: [212.247.43.194]
In-Reply-To: <CALkWK0mt1cZ22xXFXywQNk7EnZ22kq0KJfbr-GTrSg6iMXF5Yw@mail.gmail.com>
X-Gm-Message-State: ALoCoQlM4lnZ4Yrszn5ywGxsSajnmxYr1zMg7eOHqz/gjC3NtnVFMWl6JCbQB5947d8lWmernI7y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219755>

On Thu, Mar 28, 2013 at 4:23 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Would we consider shipping some themes with gitk, in contrib/ perhaps?

It does not seem like anyone is against it. I am not sure how gitk
development integrates into git's, but I guess we will have to wait
until the patch is integrated not only to gitk but also to git, before
having themes that require it. Other than that, I think it's a good
idea!
