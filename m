From: Richard Fearn <richardfearn@gmail.com>
Subject: Re: [PATCH] Fix spelling error in post-receive-email hook
Date: Sat, 13 Oct 2012 23:35:28 +0100
Message-ID: <CAA-kXAG4s661UjNGz64BVLg2ueLw=19UnMzs+_KBOk+0p8Xu9g@mail.gmail.com>
References: <CAA-kXAG5wkQQ=nxHoKq_LtE7cNUD0sLdKkW-YbNUW3d5JTmGUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 00:35:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNAJ1-0003cH-T7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 00:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab2JMWf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 18:35:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41875 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab2JMWf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 18:35:29 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3925283oag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=b12Lz641R2i7g+uAYVFDyphD6V/3xSJPKFzslsuGn8U=;
        b=TLUID7N4Vok4cc6bWoZo/7UvTTR8IhD3BMXiKAvIbwtoyZfCRcFD6QbNPAQ5TAaXaY
         W6Ivkwcv9/X9g+nyk7/oUtuoQvdXicjJTgj47qS4cGOaXiPh8MZU3U/51EV3fal+1/kv
         4h4PY3+Rt//4qWNWkhwep2XIQ+teBj0qwjdoW6MEuTjuZRP9uG8JgMI1WsWxRb7KBtzy
         SzqkByu+9JFZ6tJnNh0Lkv94YN/McH87NiGY8AogT6hY/38VkhpwpPwZWZVQ58rNvwlx
         HOxLGwP/uue066VSPhbKrcnMPF0US9gIuCrBqMMQrGyqsqvl8Tkb6P5DD2MD/1w8dk6e
         VL0A==
Received: by 10.60.23.195 with SMTP id o3mr6386557oef.14.1350167728678; Sat,
 13 Oct 2012 15:35:28 -0700 (PDT)
Received: by 10.182.4.147 with HTTP; Sat, 13 Oct 2012 15:35:28 -0700 (PDT)
In-Reply-To: <CAA-kXAG5wkQQ=nxHoKq_LtE7cNUD0sLdKkW-YbNUW3d5JTmGUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207584>

I resent this patch as Gmail wrapped it. Sorry for the noise...

Regards,

Rich

-- 
Richard Fearn
richardfearn@gmail.com
