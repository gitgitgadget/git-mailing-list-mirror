From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: congif spec in GIT
Date: Fri, 06 Jul 2012 10:55:24 -0500
Message-ID: <4FF70A6C.5010605@gmail.com>
References: <4FF6D022.10801@itcnetworks.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Radu Manea <RManea@luxoft.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnAsZ-0002Cn-CX
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 17:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855Ab2GFPz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 11:55:28 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:35363 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab2GFPz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 11:55:26 -0400
Received: by ghrr11 with SMTP id r11so8747854ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wwHhjMVUpMsSdOgSpPuwXOmrKITY2lVSkDG2E+YFJ+c=;
        b=ow4ZWNG9jrSSDp/ZikXImLYUI9APXSZANFAE3qpxWHOSb6QULUrfAQl4Xp/79UguAN
         V/WxdduSU7YYgmB+LvEv1ojvOTnlrSZ30iL1y455rVRY+N76gKISpHkI4KJCBg9K8mXw
         5OPpgs62zNwH4ImLr51xFwKkIOnqCKxr1EbHDlmIJQcBqVS+uXtFLnIN4rGCu+z3KALl
         jvfoIGuZ5b0NxgQYdSYPrFJ5e9LHPoszk0Qa7Yv7d22qXXw3PL3MeW+B5iJSPTTzPWB7
         paU7PZ/LkY8AnG1AyQ4kLxTXAebZdkIDBy1qdo88b8up5KZ0xbmCXUO9IyCTGXgO4F6v
         h/hg==
Received: by 10.60.30.35 with SMTP id p3mr29916752oeh.16.1341590125831;
        Fri, 06 Jul 2012 08:55:25 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id qk5sm20114667obc.10.2012.07.06.08.55.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 08:55:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FF6D022.10801@itcnetworks.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201117>

On 7/6/2012 6:46 AM, Radu Manea wrote:
>
> Thank you for the detailed presentation posted on git.or.cz site.
>
> One question: is there any equivalent config spec file for GIT as is in
> ClearCase today?
>
I don't know clearcase, but have you looked at git-config manpage?
http://git-htmldocs.googlecode.com/git/git-config.html

v/r,
neal
