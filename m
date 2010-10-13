From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Wed, 13 Oct 2010 15:35:04 +0400
Message-ID: <9DB2A1C4-F0A3-4920-B409-AA267EB2FC57@jetbrains.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com> <AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com> <C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com> <38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com> <AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com> <AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com> <m3aami731j.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 13:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5zc5-0006VR-5s
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 13:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab0JMLfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 07:35:08 -0400
Received: from mail.intellij.net ([213.182.181.98]:57280 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab0JMLfH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 07:35:07 -0400
Received: (qmail 32562 invoked by uid 89); 13 Oct 2010 11:35:04 -0000
Received: by simscan 1.1.0 ppid: 32506, pid: 32553, t: 0.0129s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 13 Oct 2010 11:35:04 -0000
In-Reply-To: <m3aami731j.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158929>

> Isn't IntelliJ IDEA written itself in Java?  Perhaps you could use JGit, the
> Java implementation of Git (though it is not complete implementation yet, if
> I remember correctly).  It is EDL (new-style BSD) licensed, and is used by
> Eclipse and NetBeans.
> 

Yep, we thought about JGit. 
But people say that it's not stable enough, and not completely implemented. 
Personally I haven't tried it yet though.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
