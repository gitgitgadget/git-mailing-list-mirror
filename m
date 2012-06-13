From: lei yang <yanglei.fage@gmail.com>
Subject: how to know this commit is merged by whic commit
Date: Thu, 14 Jun 2012 00:50:59 +0800
Message-ID: <CAHsH0E9HooVsAq8NhWm-OSk7gSPFMmoYHsArtYqhwTmE0ngwjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 18:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seqmf-00041s-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab2FMQvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 12:51:00 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44028 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2FMQvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 12:51:00 -0400
Received: by vcbf11 with SMTP id f11so444216vcb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CldF/TaAX2NN3Rr8OUN7aSVynSno9alKt5gqvxWoAvs=;
        b=TNzG6xjPEpbZgpdIH3AjOUUfzTIPDjo4858bGLepIFlNmpjWoMWCnzUpvrmHZR4ZOV
         InNfN/s8RaXaxhrIe1M0PUbvbh7T3dup0UByY4dVYfAJDojhg6t22HUWdTkDGs5vh3hq
         PuWw26h0fi3Hux/1rUCbZubDEGRdDhlWB12RMeButQeXjHwKnQSG5zCuL+nXQY41O73Y
         1L09MURDwH2pD19oueWhLQX7NBcW4pyyo47ZN5McPdbyihwQrx+M6l2vxr0gO9tFndwK
         FXYfk5nTCv6sQvpsLpmnn0fWMlAZiagUA8ESQD59rzKveXtQYOGNVFaOqSaenMMXnLvH
         zIXQ==
Received: by 10.52.72.79 with SMTP id b15mr14440271vdv.13.1339606259213; Wed,
 13 Jun 2012 09:50:59 -0700 (PDT)
Received: by 10.52.97.35 with HTTP; Wed, 13 Jun 2012 09:50:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199900>

Hi list

I have a question as the title indicate. assume the commmit id is
ee5r3343. how to know this commit is merged by  which commit?

Thanks
Lei
