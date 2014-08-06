From: Tony <ssk@toanii.com>
Subject: Re: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 13:23:00 -0700
Message-ID: <CA+Cdr4kobYDVGJneBXENYj=hmC6YEM=BYqGoAFvUNeaeYS_L5A@mail.gmail.com>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
 <20140806184304.GB21254@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert P Fischer <rpf2116@columbia.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7k4-0001vn-U5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbaHFUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:23:21 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62226 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaHFUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:23:20 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so2265665oag.33
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fZojsI26+C1WOwqeSpTZ49r4Y77lm92mVGg8smuxXEM=;
        b=e9vZ+mQwDf5zFhk49jyLBeI4ITZYGpBjiWztQ5qtvAwB8EOae8wd1BvSqRGHKF1V0f
         uqVJruOcmhiMgiRZdkaqJLiBDA1i4jkg1kuOMHWQza3vtKzWEAMqgobMIdr61m8ug3ws
         4jnzr59YmCJ+vXMvd5PY7EvufTrQ/aMuvy15qu4ea7CknEDbsx7Xq0KzpgNDgyeaMpU5
         C2Cg0WskE9MC/eYHujmIaHaJ+whtUxVbSY+U8lJMjeOwCATBZKYrGWX8FUXd884HtY/N
         4oGDi8QR6fHAuWAcPbAPK6z07DE21GQ/vFo8XWfi57ZTXhbdDJhDW6VkZBiq6sRkf8Zw
         t7Ug==
X-Received: by 10.60.94.208 with SMTP id de16mr18191702oeb.52.1407356600294;
 Wed, 06 Aug 2014 13:23:20 -0700 (PDT)
Received: by 10.202.226.206 with HTTP; Wed, 6 Aug 2014 13:23:00 -0700 (PDT)
In-Reply-To: <20140806184304.GB21254@peff.net>
X-Google-Sender-Auth: pNIz5DAJVRlIN_w08PNTWhtbUB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254902>

> Also, minor nit, but git is GPL, not LGPL.

But Apple put a LGPL license in side the folder. See:
https://www.opensource.apple.com/source/Git/Git-48/src/git/LGPL-2.1
