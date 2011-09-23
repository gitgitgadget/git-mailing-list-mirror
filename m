From: Brandon Casey <drafnel@gmail.com>
Subject: permission to re-license archive-zip.c and zlib.c as LGPL
Date: Thu, 22 Sep 2011 22:51:14 -0500
Message-ID: <CA+sFfMdzMCJut385jCJ88Z8sUw3E2Bs2A1SiECORQsFJjsb=Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: rene.scharfe@lsrfire.ath.cx, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, dpotapov@gmail.com, vagabon.xyz@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 23 05:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6wnR-0004VA-Jq
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 05:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1IWDvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 23:51:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36794 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1IWDvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 23:51:16 -0400
Received: by fxe4 with SMTP id 4so3400600fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=W49F4K1z0lFl4Ei3OaalH7Fc3PNUNzWy7s2FX5HUXzI=;
        b=UPFrfnDk61SZF3w5+5TzbEStmZ/fMElgPbZhvGDxxn2dFVUxuYfTBHTgqdnHa0svE6
         IKIc1r9uT6+KJgUKTJDoNl9sb4xc453ZA3F0jJb6oZNWbGG2wOiU0ALxXgMjGBBzLncv
         bB0D+7PC5bpn8GlmXAyJhk2qEHIR+ISzb7+vI=
Received: by 10.223.94.134 with SMTP id z6mr4287573fam.8.1316749874940; Thu,
 22 Sep 2011 20:51:14 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 22 Sep 2011 20:51:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181940>

To those who have contributed to archive-zip.c and zlib.c,

I'd like to make a library for writing zip files.  I really don't see
another library out there that does it as easily as archive-zip.  So,
with your consent, I'd like to re-license the code in archive-zip.c
and zlib.c as LGPL so that I can create an archive-zip library.  The
reason for LGPL, of course, is so that it can be linked with non-GPL
code.

Please offer your consent to re-license your contributions under LGPL
by replying to this email.

All comments welcome.

Thanks,
-Brandon
