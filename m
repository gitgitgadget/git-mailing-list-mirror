From: Parag Kalra <paragkalra@gmail.com>
Subject: 'p4 sync' like command in git
Date: Mon, 29 Aug 2011 17:52:34 -0700
Message-ID: <CADSDpOCATv+0Shm630LcvE52e03WiBFdu5wQjdiH4TCJBmkmSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 02:53:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyCZY-0003r5-NW
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 02:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab1H3Aw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 20:52:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41332 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1H3Aw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 20:52:56 -0400
Received: by fxh19 with SMTP id 19so4970264fxh.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3Sqe3o7RsTkGxtpkaRpqMQnvMrMncYWOtL4srZ1QCno=;
        b=UyeKy3G+NCImYZ07nUxhpzXWVQBCBYYF6KL7hzZIJV3Xd4qS/k5WCyxh8nFB5Hxss4
         hDwn0+DuIlfvHulbjERjGYj2nIhIjJ/3A0i1oqvz6F/TbAvyopdUVp6C0h0sqCYXm2Sz
         QSktIHo8jjWJfWVA6+8Mas/jyZ4vqdN3fdmV8=
Received: by 10.223.16.205 with SMTP id p13mr3828588faa.69.1314665574779; Mon,
 29 Aug 2011 17:52:54 -0700 (PDT)
Received: by 10.223.144.195 with HTTP; Mon, 29 Aug 2011 17:52:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180382>

I was wondering if there is any 'p4 sync' like command in git.

I did some google and found this -
git pull git@example.com:pk/foobar.git

And it seem to work for me but want to just confirm.

Thanks,
Parag
