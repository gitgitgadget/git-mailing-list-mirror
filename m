From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] show signature of commit in gitk
Date: Sun, 13 Dec 2015 13:10:10 -0500
Message-ID: <CANoM8SVhRe5HqJXjizZBp7Qdg-9ig7HQGyEDEZOxYKzZqaX5MQ@mail.gmail.com>
References: <565F443D.7050205@cotya.com> <566D7D82.90107@cotya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	paulus@samba.org
To: Daniel Fahlke <flyingmana@cotya.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 19:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8B6y-0004J7-C3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 19:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbbLMSKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 13:10:30 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36851 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbLMSKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 13:10:30 -0500
Received: by obber4 with SMTP id er4so33719924obb.3
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vLKtJYpQ4fX88jTK7ijPjwOwv/VnY1Ugwnh7NK1ojOo=;
        b=mKAL1h9jl0q3+EBomGbs8kiFhbDz5ET9CY1qHWmpTKibbeodlYbO2YlzL8YfceOy5/
         gIADlkMS8JBvXhFQ0ZhcL3e9X9Vy+KpkwOoqqheTMTVcgvBDbIBdOR3fl0MtaXM64mkI
         DMpOhztLJYWugx0CbJQsLJSS7Et0rUke6dbZz5s2+1b/YJZXeXDYe8G5kYl6DdsAMtHD
         Iwj7IQoxU4EHd0vLmHlnbyecfmMvnfmgF97HDkIQcAhyXFnO5rDoG/dbov1QOvYLN41h
         UBSefRpTMrLyrLXsopUJ/GX+aKmLnaE1bK4+J0koPbtkW8+Kqt6XU7VlEAjgt5vHxgFf
         MlvA==
X-Received: by 10.182.19.234 with SMTP id i10mr21733059obe.67.1450030229387;
 Sun, 13 Dec 2015 10:10:29 -0800 (PST)
Received: by 10.76.62.15 with HTTP; Sun, 13 Dec 2015 10:10:10 -0800 (PST)
In-Reply-To: <566D7D82.90107@cotya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282338>

On Sun, Dec 13, 2015 at 9:15 AM, Daniel Fahlke <flyingmana@cotya.com> wrote:
> It seems my Patch got no attention yet, is there anything wrong?
> Do I need to ping someone in particular?
>

gitk patches should cc +Paul Mackerras <paulus@samba.org> who maintains gitk
