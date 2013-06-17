From: shawn wilson <ag4ve.us@gmail.com>
Subject: smudge filter
Date: Mon, 17 Jun 2013 15:29:07 -0400
Message-ID: <CAH_OBieVCkQY9d7YT8c=Wd1WyDeKRGgWDmviP8tG9vh3M4uR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uof7M-0004zp-UY
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab3FQT33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:29:29 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:55386 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3FQT32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:29:28 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz10so2443928veb.22
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=mVN1LET89VPJsWc5aLCE8LGlY7G0nWG4X7ag2X/uSrY=;
        b=tMrvOABiG558+1k/4A5E4Njj/FQP12TSPt6DxQT7x1tV874IK31AIynoJjllRIaLPB
         Khrasp/gqfKcLdLtzW46FeNnApdlx3TKDVvYNLtWZgYflKVpfkXHXwEzdu6BZ/h2Sc/q
         nm2eCqeLRKOchgVVfY8bBbJZ/o9DPkbIrQTxi75gEVIkwehzWGghLfMvVCS34NB7j5yE
         H9OEXVLiCNnUWrdf6IPf8KsQExxI9P4NiKcmYJkMFvyXBuRmMBCvi9uSkSur1kj5drPL
         3QFPDvCaZFGDs/LWWiaWCPeH8BbRldoQJh01o8fHKrCVPL/aE7fbdl2Ptv1/XGbERUDS
         hHGA==
X-Received: by 10.52.248.206 with SMTP id yo14mr636025vdc.61.1371497367835;
 Mon, 17 Jun 2013 12:29:27 -0700 (PDT)
Received: by 10.52.116.72 with HTTP; Mon, 17 Jun 2013 12:29:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228102>

Can someone take a look at this and let me know what I'm doing wrong?

Also, what's the best way to test filters? I can't really do -Debug or
really even print various output.

https://github.com/ag4ve/github-test
