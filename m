From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 21:47:57 +0200
Message-ID: <CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<535572b73183b_414c80b30863@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:48:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcKCA-0000r5-Rc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbaDUTr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:47:59 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:47716 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDUTr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:47:57 -0400
Received: by mail-yh0-f50.google.com with SMTP id t59so1996361yho.37
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zd/uYzQmJgGf/1bvkXYSJy1ayoyD2abmSrTD7ftjnEs=;
        b=PE5H2Kucj07N66FcLUR8TBvghQz5HMPi5ofGiU5br9JYKYaBwEkhdhf9ZnwGZ1OezI
         zZ4IEqfpVJ4bqarA0X8t6HwBoDgvbftd4Nc9ZBTvEjhxQHtXFEmU3X8VnNkVpPCFi3Ki
         dsDljC1/5BvKAvIh96BcKJlGYnCQ6mNTQqgZx9QZJNP4JBtDI1fRhdP/0w14ITTwcafB
         Qk2/m4VQgClr/JSOs7FwvBKmFvz9tjEYWmB1XLtIBPLr6t4G8f8fFn8JQoyNqmlL0S4A
         R7bd7+SJKXpdFSaZ9+zY4aHCg58c4l7YhTakEEeemN925ac9TbqulE5vUNa8qZKwYXHt
         CRug==
X-Received: by 10.236.92.210 with SMTP id j58mr55769863yhf.5.1398109677118;
 Mon, 21 Apr 2014 12:47:57 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Mon, 21 Apr 2014 12:47:57 -0700 (PDT)
In-Reply-To: <535572b73183b_414c80b30863@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246628>

On Mon, Apr 21, 2014 at 9:34 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> I have these aliases as well, except br => b, and cp => pi. 'br' is probably
> better, but not sure as 'cp' which can be confusing.

If by confusing you refer to "cp" to copy files, that's actually what
I like about it: cherry-pick is somewhat like copying commits, thus
"cp" makes much sense to me.

> FTR color.ui = true is not needed any more, also hopefully mergetool.prompt =
> false wouldn't be either [1].

Thanks!

-- 
Sebastian Schuberth
