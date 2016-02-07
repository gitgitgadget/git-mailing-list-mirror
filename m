From: Jagan Teki <jteki@openedev.com>
Subject: Add Cc,Tested-by list while 'git commit'
Date: Sun, 7 Feb 2016 20:53:27 +0530
Message-ID: <CAD6G_RQyTYPzFBb5Sm9zzAXAe48Ln08Jd7W0aecUN-hYoVy+gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 17:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSRx4-0006jS-Np
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 17:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbcBGQME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 11:12:04 -0500
Received: from server159.web-hosting.com ([68.65.120.118]:45765 "EHLO
	s159.web-hosting.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbcBGQMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 11:12:03 -0500
X-Greylist: delayed 2911 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Feb 2016 11:12:03 EST
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32963)
	by server159.web-hosting.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.86)
	(envelope-from <jteki@openedev.com>)
	id 1aSRBR-001mNI-Dj
	for git@vger.kernel.org; Sun, 07 Feb 2016 10:23:31 -0500
Received: by mail-lb0-f176.google.com with SMTP id x4so72740003lbm.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 07:23:29 -0800 (PST)
X-Gm-Message-State: AG10YOSb8umZNr6+GTJkEmm4nTnlUKR6/zmc51dx9mGjmQIrdXxezaTRvyM3duX62V/aRLeqha5cB618F4Ss8A==
X-Received: by 10.112.62.165 with SMTP id z5mr8211422lbr.89.1454858607826;
 Sun, 07 Feb 2016 07:23:27 -0800 (PST)
Received: by 10.25.25.149 with HTTP; Sun, 7 Feb 2016 07:23:27 -0800 (PST)
X-Gmail-Original-Message-ID: <CAD6G_RQyTYPzFBb5Sm9zzAXAe48Ln08Jd7W0aecUN-hYoVy+gg@mail.gmail.com>
X-OutGoing-Spam-Status: No, score=-2.9
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server159.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - openedev.com
X-Get-Message-Sender-Via: server159.web-hosting.com: authenticated_id: jteki@openedev.com
X-Authenticated-Sender: server159.web-hosting.com: jteki@openedev.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285732>

Do we have any git config options to add Cc and Tested-by list like
Signed-off-by is fetched from git config.

example:

$ git commit -s

Cc: Arjun Ani <arjun.ani@abcd.com>
Tested-by: Jagan Teki <jteki@openedev.com>
Signed-off-by: Jagan Teki <jteki@openedev.com>

Please share if we have any inputs to solve this.

-- 
Jagan.
