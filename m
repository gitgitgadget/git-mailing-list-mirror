From: "Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
Subject: GIT Error issue
Date: Wed, 19 Apr 2006 16:46:57 +0530
Message-ID: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 19 13:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWAgQ-0002gE-Ip
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 13:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDSLQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 07:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWDSLQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 07:16:59 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:18958 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750857AbWDSLQ6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 07:16:58 -0400
Received: by pproxy.gmail.com with SMTP id i49so1264340pye
        for <git@vger.kernel.org>; Wed, 19 Apr 2006 04:16:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B1JZSjvPqI20HVFK9e6Qd4EKOyCaRS3iFV7PyWdmjbtuGSUSfC4pnZ0MeSuA4dI47f9YB2yAGNQhm/i4yCKt1QODW0c61iJ4xIs3nQ7fuDqYFMgtMpGMUjP2VqFEuL9FZ7jyQi+R9ZW51sFdQYJ+D0WAKksfCESNK0UO0IQ6KkQ=
Received: by 10.35.8.1 with SMTP id l1mr1252864pyi;
        Wed, 19 Apr 2006 04:16:57 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Wed, 19 Apr 2006 04:16:57 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18918>

Hi,

I am newbie to GIT and facing some problem with the GIT usage. I am
trying to clone a repository at www.linux-mips.org with the
following command, I get error message as below:

**************************************************************************
[root@sshyamal git-tutorial]# git clone
git://ftp.linux-mips.org/pub/scm/linux-malta.git linux-malta.git
git: warning: invalid extra options ignored

GNU Interactive Tools 4.3.20 (i686-pc-linux-gnu), 12:39:46 Apr 18 2006
GIT is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free
Software
Foundation; either version 2, or (at your option) any later version.
Copyright (C) 1993-1999 Free Software Foundation, Inc.
Written by Tudor Hulubei and Andrei Pitis, Bucharest, Romania

git: fatal error: `chdir' failed: permission denied.

***************************************************************************

I am exercising this command in root mode.
I have browsed through FAQs/archived mails but haven't come across
appropriate solution to this.
Can anyone please let me know the problem cause for this issue?

Thanks and Regards,
Shyamal
