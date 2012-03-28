From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] am: support --include option
Date: Wed, 28 Mar 2012 16:56:15 +0530
Message-ID: <CALkWK0mvF=YWP5FDaDsY5OeW00_PqKokZ2t5Ev_cpbi0+2rJ+Q@mail.gmail.com>
References: <1332933088.3479.27.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 13:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCr1X-0006Rp-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 13:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab2C1L0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 07:26:38 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48176 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab2C1L0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 07:26:37 -0400
Received: by wejx9 with SMTP id x9so563198wej.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZxGIhDAceVcs6J1SG9614ylXOhp8tMh6IpOrZ1m51go=;
        b=tOKqFxWEPvgxlUjOhFYjof/UnDzR/t9aaV8LEAcwQQu3+YQu6EF9f+WrxYKKA54CXx
         zk8TUk1ktkah1AtqqAkFbfX/E+4XtdtXV3TWnQHQ+53ZAsfmIaXuBHz9IwYOAu+yX/l1
         kHIRUPZvSJ8MRUSm4moyj1DNqb+aAWXTbKy2CnadtYfc3OacKhNFcluQ9siSX0QBqKok
         6GE3WxXubMHnwwSJBB5a+jcKReU667yg7r3tOZ+PzpdjIuRwZdoLl1TLXTR9NtrjYgdT
         uyXFQYrKYsNvl8PuAESYWRSc+Ws1BQW44TW5K7nJG2HkH1iMso5CTdRnBBWz6TQgzoBC
         mihg==
Received: by 10.180.85.35 with SMTP id e3mr6199625wiz.6.1332933996116; Wed, 28
 Mar 2012 04:26:36 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Wed, 28 Mar 2012 04:26:15 -0700 (PDT)
In-Reply-To: <1332933088.3479.27.camel@jlt3.sipsolutions.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194119>

Hi Johannes,

Johannes Berg wrote:
> am supports a number of pass-through options
> to apply, like --exclude and --directory. Add
> --include to this list.

Looks good to me.  Thanks for working on this.

    Ram
