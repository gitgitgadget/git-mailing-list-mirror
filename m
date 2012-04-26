From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 16:34:04 -0700
Message-ID: <CA+7g9JxpLs9rqRpacmLvnJ-2mZPCT+Bwd8J4-vp27HCZPTS0pA@mail.gmail.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
	<4F99AACC.2050409@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 01:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNYCT-0005mX-2q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 01:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438Ab2DZXeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 19:34:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab2DZXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 19:34:06 -0400
Received: by bkuw12 with SMTP id w12so101826bku.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 16:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=/Cz9uueNZq9UH53FvMG+oBEuvNtVxxvcI8Ru90e1GE0=;
        b=f82RvzKd+HNHRcsWK1KXmYM+SciSslCdXVJRKrj/BIyF8iNMdctaJbmc43PmHipl4N
         ab+rnY/kSwIL9GrVarUoeDBolDFfH39SRJ5rCP3hf0mboTRHOAIUh9E6ougDomfsKuuH
         AsbOcPPIf5efJshvl8fLu1Gc0EnAUjmjDlq6n+wUyTzRr9CjJxfxnc5Qy26MWO5DbaQ0
         Q9B2VsIxMYXS8lK6FLSU8UFUK6ZZKoIUJfzfBqivSTByPh0HGiwUW18VPSrEhf2ivDIJ
         2+BeaegKXvEWPb4jzzxmg8DJ2yppy5WyqWuKGgqxRzRTZNLNqJx8RLbtWVo2BoCulBq8
         urRg==
Received: by 10.204.155.92 with SMTP id r28mr1068571bkw.130.1335483244893;
 Thu, 26 Apr 2012 16:34:04 -0700 (PDT)
Received: by 10.205.119.8 with HTTP; Thu, 26 Apr 2012 16:34:04 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <4F99AACC.2050409@xiplink.com>
X-Gm-Message-State: ALoCoQmtqfrySNJzpIYEY6f+C5EZ4sNZq7V1YgnhGD4WQFwWQuB+Z3xA8IHpHqO+rJjobmQZ9QNx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196446>

On Thu, Apr 26, 2012 at 1:06 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>
> There was lengthy, but inconclusive, discussion about this a year ago:
>
> http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=166290

Thanks for the reference.  I'll give that a read.
Cheers,
-n8

-- 
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
