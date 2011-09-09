From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Chances of getting gitk series merged
Date: Thu, 8 Sep 2011 21:08:57 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109082055560.12564@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 03:09:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pac-0003sm-K3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310Ab1IIBJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:09:02 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:56870 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112Ab1IIBJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:09:00 -0400
Received: by vws10 with SMTP id 10so683914vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        bh=T4x594CUSMwGtslDe72YIIu68G+NrsAQ1gstTSh3gUo=;
        b=UzZiHfnGAXjNx8hkjO9HxSzWaPCW+IxugrJoW+hCcGxOS/PTzFAI3uxmQB0Ci2mGJl
         IQRAZMCiShoTAdbPFDaCMaIe6SAAA4E+fsBzhtcZiGMQ8a9Nr2wgLYNvHeNsnUJbqPHA
         u7ZftojfcGkTilwPPCGJKyAPVqHLDlr/x1pjc=
Received: by 10.52.23.20 with SMTP id i20mr151336vdf.356.1315530539614;
        Thu, 08 Sep 2011 18:08:59 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id jo8sm3821633vdb.20.2011.09.08.18.08.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 18:08:58 -0700 (PDT)
X-X-Sender: martin@debian
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181016>

Hi Paul,

I was happy to see in another thread that you are still here. If I
understand correctly, you are the maintainer of gitk, meaning that all
gitk patches go through you and then Junio pulls from you. I have this
series [1] that I sent in out in April that I would like to get
merged. Could you have a look at it?

Thanks,
Martin


 [1] http://thread.gmane.org/gmane.comp.version-control.git/170853
