From: Levente <leventelist@gmail.com>
Subject: Windows download broken?
Date: Wed, 16 Mar 2016 15:06:41 +0100
Message-ID: <CACwWb3Dm8CfhZKvfNz-4Pj=tytf3zroFxnbbTq9DM+xm4EPEig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 15:06:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agC63-0002f6-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966157AbcCPOGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:06:43 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35418 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933008AbcCPOGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 10:06:42 -0400
Received: by mail-io0-f174.google.com with SMTP id g203so60338700iof.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=52N6fyX6K+rSS80QfDlfg2Ub99JKf+DvW4kkX0fYwgw=;
        b=JVaJhGfLFVsRFgtlqZ/UUtUdTBj+CzUmIAQWoFMvBXXs14sN90FiDkedf0LlFLwdAc
         k9ZEAP5t52VBU9YXWvOC1Q9xge/ZUtagZIfYJzLs57mgqR5+xuFo9uP29DJpni6k+2Aj
         FQIfmjkw4JPSYgXGvZYVxO3s+hDtK7qdh44uwgU7nXpUIycfXklW+c5rypY9orHQ4h79
         w8PuWDQxn5hVLBEmwRaZ2um8N1hghKtMlC8VJRpntUl1nvz46YBdCB2+31c591aYuO/X
         oqAmq/+5I6GYIdPqYeM6R7z+/UyDj8hD5rpvqmX4qztQ6pXP4EbaTnErFptdMQ6LFdX5
         siLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=52N6fyX6K+rSS80QfDlfg2Ub99JKf+DvW4kkX0fYwgw=;
        b=Ofc9dMgBWke10vABXvzhDcXO9nvEjdlYvszmJ1LNQ7iJ/QZNvT/O9qKOYpwMfmtAC4
         +7W3C5Kr6yXRo+lHUp4zTEByMYc5c4J7uK3bVITnBU1+me9t5g13XjT/RzLmnIrx9MCb
         JmDUikQ3K7yKQsBLyYOtmRjLg7MHYzJCk1j0NeII44lW6GVxz9qvJxlCk7iIo0P3/NaO
         MiWin9tt/QU+5UpopCMwWYiHMDInB0DDZK25wH4RamOcI6wCoFnXzQkd5vXIFQkrJCrY
         pduz/OXXU16Ght+jgwesWvcO69txV9Sp3sHOBttC1MKjBuk2tdUqu/+oaPZF3kLG0wMj
         uDMg==
X-Gm-Message-State: AD7BkJItZKw8NC14fTLBHkYWwZQNH7vChEOiWPpV3pGzCUVpP7D4sYVN05sIj535OkJx/Aru00vabKUVrxt9fA==
X-Received: by 10.107.185.6 with SMTP id j6mr4335164iof.77.1458137201712; Wed,
 16 Mar 2016 07:06:41 -0700 (PDT)
Received: by 10.36.133.195 with HTTP; Wed, 16 Mar 2016 07:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288973>

It seems that this link is broken:

https://github.com/git-for-windows/git/releases/download/v2.7.3.windows.1/Git-2.7.3-64-bit.exe

Regards,
Levente
