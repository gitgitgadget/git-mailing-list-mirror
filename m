From: avinash r <nashpapa@gmail.com>
Subject: Compiling git svn from source
Date: Tue, 10 Dec 2013 19:27:24 +0530
Message-ID: <CAHCisteVsy4_GX_1PNZfO44w1WmW28vAY0PBfwo9CL_Ze8fw2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 10 14:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqNor-0005VX-QI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 14:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab3LJN5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 08:57:45 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49933 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3LJN5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 08:57:44 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so7414202pdj.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=obAcG43xtbLxG6d/lxSxxmiohrIoHNvtoLG/9vArNfs=;
        b=sC+Ebqc03jM0UIPs2euq5/xMk58eBp/d8sPJEyV8v3xeXzOr8uvzpBD7tn2bea7vNa
         mOQIZdrddvAjWChnkvbxmUQY2OqQZVCxWjqLNFPpy5xE/WWyHkVPqNKl1FRKrKOcf+P9
         PWX6b/7BdXU4FM9kkGg6lEkeKpkWqegJz2cwzJYCIZ1I7f1qam51vLvIzzI+fGM5gJSM
         YvVGCqcimJ0VifyKayhU5E6/sAv/gwEQu2QqTWY0xGHJwYQHRDpOl6jCTETu8DhhqmGe
         5Q/y4n3N/qvU2vG9TQT6g8/oxneKJRYDp5nazv7eQImE5ygz2RFHPvBaFKfWlRTg4qTq
         /2sA==
X-Received: by 10.66.141.231 with SMTP id rr7mr27445073pab.41.1386683864529;
 Tue, 10 Dec 2013 05:57:44 -0800 (PST)
Received: by 10.70.95.104 with HTTP; Tue, 10 Dec 2013 05:57:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239138>

Hi,
I'm compiling git from source due to outdated binaries in
Linux-flavour 'X'. I followed the installation instructions at
git-scm.com, but somehow the sub-command svn (git svn) is not being
installed.

How us it that I would be able to install it from source?

I have Googled for this,  and the top result suggests to ask here.

Here is how i'm compiling:

$ make all

$ sudo make install

I'm hoping that I'm in the right place.

Thank you,
Avinash R
