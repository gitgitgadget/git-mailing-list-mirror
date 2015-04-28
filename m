From: Thiago Farina <tfransosi@gmail.com>
Subject: curl
Date: Mon, 27 Apr 2015 23:49:51 -0300
Message-ID: <CACnwZYc8VvQ4mh3pbVcd06uc6YZOXnrGOEpTu19qacBy8v_Y8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 04:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymvaw-0001fZ-16
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 04:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbbD1Ctx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 22:49:53 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35891 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbbD1Ctw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 22:49:52 -0400
Received: by oift201 with SMTP id t201so105747690oif.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 19:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lvdTNACoihta+UbPRmgCXyXVfx6bIGBC6ChJqGbFE6M=;
        b=XYEmjB87IckVoKdjUOuwDg0iJeAD4a5dY47Vksmv0ZwUQ36d4KlMFBjtMSwPcrNFZ1
         jgeEd6440+MEm4hQ3hb5xTnlF2bBTwcnR/qYsv6m1ZzxxUrzzRfQ03EggeCPcUxD6WfW
         qg5Ty3BmvGbTPh5XbfEpc3PW32YdY+IWFg+/NBu7J1vZUXaeT4GzHyYUbeksJJYplYZC
         dUVnPw7OGveHfmXqL3nzmVkglF5G7MqzoqpJWjQgmpTKPU1Yh5kY63sMCm4i8Zkfauxl
         I2M2NKSqaH/nOwcTWK9CNIis+VOC3usBHVf88DpKaQUKC1A3mBqpEqO5lar/fLtAyT0y
         /njg==
X-Received: by 10.202.170.135 with SMTP id t129mr12109670oie.40.1430189391552;
 Mon, 27 Apr 2015 19:49:51 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Mon, 27 Apr 2015 19:49:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267889>

Hi,

Is it right that git uses libcurl to download while libgit2 does without it?

-- 
Thiago Farina
