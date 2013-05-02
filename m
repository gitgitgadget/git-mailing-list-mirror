From: shawn wilson <ag4ve.us@gmail.com>
Subject: removing a bad commit
Date: Thu, 2 May 2013 06:15:58 -0400
Message-ID: <CAH_OBifxVOaFMXCthm+r30GNaqrsLRoBE-wvzkeKVxw7R2gGFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 12:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqYq-0004bo-L0
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 12:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3EBKQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 06:16:20 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61087 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3EBKQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 06:16:20 -0400
Received: by mail-wi0-f171.google.com with SMTP id l13so399039wie.4
        for <git@vger.kernel.org>; Thu, 02 May 2013 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/ZyTDg9uVphKEdUqwPqtZTTB12dwr1W56sKmpxERNk0=;
        b=cHCf1p+SB1Crd4Sna+0aofMe3yQ4oC1c6SmznTHffJsOGcT9Wu85bbxABYe2YEDRKA
         ucH0nmqJYJoT1aXg3jFfuq0gCmqwJ7XMUa2EeSXMozteJG50+wFPUmRbEu7dgr+vsCh+
         wpybZevdD0inYoR0utVnB5luRRb6C7/606Z6qeznxTXtVa6hGAgP3cZOcQ+HnJHIChgI
         8PWgz5/5Z0sHjH74GTzVjtCpF+IK7w017Et52tZAwH0dGh+CZT28fWmAQxPLw6fuB8ta
         1kI/2az3tZ5+kO8d1FEYmN2yp/A4Ja1VnxoY27t6o4atJaKfwulNyQuc4Cml8WGbgdXL
         5Sdg==
X-Received: by 10.194.109.227 with SMTP id hv3mr6870180wjb.32.1367489778659;
 Thu, 02 May 2013 03:16:18 -0700 (PDT)
Received: by 10.227.106.200 with HTTP; Thu, 2 May 2013 03:15:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223189>

I've got a commit that was done about a week ago that I want to remove
(preferably remove and rewrite history as it's in a branch and it
doesn't need to be in this branch until the branch is working) but if
a reverse patch is the only way, i'll go with it.
