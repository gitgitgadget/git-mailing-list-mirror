From: Thiago Farina <tfransosi@gmail.com>
Subject: cmd_struct
Date: Wed, 13 May 2015 20:10:47 -0300
Message-ID: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 01:10:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysfnh-0008KD-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 01:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934672AbbEMXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 19:10:49 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35706 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934661AbbEMXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 19:10:48 -0400
Received: by oign205 with SMTP id n205so43441308oig.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tbwX+FbJwfyCuScKRMX1uW0dpaf6idQp+YaVohlo5ww=;
        b=uyoatHAw+7idANZpE8Gw8j44wTYF73lU4rcxnGpV5PuCLGMVHUhvq51SNHiXxbZTSD
         jvMyr00U4uoe8m+peLI+47l8l7fGtr2QvRzWbc0VJOkAYZ4BE5gYyaeagCAy4i7gnlnN
         POaBBIngYbmzQIIJipEGY/eTAlFsWnmHRzh3XeY8ZT+gKd6JIA8yRGCyvUMZZOSQ6lnM
         2tgJhZ5DTvEkyL98udjuNbSGneX9ZNYxhPxsWjpS1+ZD3ume36Xt/y7VHcUev4+AkbQf
         kHVYhSQ3dmq1amjWZuBJnY3Xfc/uiShVSmE55ytgLPoGvXDttM+VBWKokANpW8aPD3Go
         8dag==
X-Received: by 10.182.78.103 with SMTP id a7mr1038647obx.79.1431558647916;
 Wed, 13 May 2015 16:10:47 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Wed, 13 May 2015 16:10:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269016>

Hi,

Would be too churn/noise (at this point) to rename cmd_struct to builtin_cmd?

I know "Why" question could come, but I prefer to not answer it if I can.

Regards,

-- 
Thiago Farina
