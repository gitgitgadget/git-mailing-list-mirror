From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Sun, 8 Oct 2006 16:22:23 +0800
Message-ID: <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	 <eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	 <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 10:22:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWTvZ-0003Lc-Lt
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 10:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWJHIWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 04:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWJHIWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 04:22:25 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:57424 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750912AbWJHIWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 04:22:24 -0400
Received: by py-out-1112.google.com with SMTP id n25so1863672pyg
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 01:22:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bz2S2fRZm7MyHWqvO2BS/FnvL/R1tPxvznxya1ixtuXFGBRr27H4d0rtx3SYVFQSJgUP5S9wisSXY5U+6ci2rECLtzRchl5NkazoHxXADkBCARiVeMH4DEUfdSc3DaOFb89iuIwGv2DjMLI39L+05qgTKDc1NyTZeDlstOkatKQ=
Received: by 10.35.40.10 with SMTP id s10mr10006794pyj;
        Sun, 08 Oct 2006 01:22:23 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Sun, 8 Oct 2006 01:22:23 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28525>

> >> Not enough information.

There is gitweb address:
http://www.foresee.com.cn:8888/git/

bad output:
http://www.foresee.com.cn:8888/git/?p=gcc/.git;a=commitdiff;h=c977ee1b2e54d67bb379ce476f784431c32136d7

debian pkgs:
ii  bash                            3.1-5
The GNU Bourne Again SHell
ii  cogito                          0.17.3-2
version control system
ii  diff                            2.8.1-11
File comparison utilities
ii  git-core                        1.4.2.1-1
content addressable filesystem
ii  git-cvs                         1.4.2.1-1
content addressable filesystem (cvs interope
ii  git-doc                         1.4.2.1-1
content addressable filesystem (documentatio
ii  git-email                       1.4.2.1-1
content addressable filesystem (email add-on
ii  git-svn                         1.4.2.1-1
content addressable filesystem (svn interope
ii  gitweb                          1.4.2.1-1
content addressable filesystem (web interfac
ii  kernel-image-2.4.27-2-686       2.4.27-12
Linux kernel image for version 2.4.27 on PPr
ii  patch                           2.5.9-4
Apply a diff file to an original

But the other debian 2.6.x kernel is OK!
