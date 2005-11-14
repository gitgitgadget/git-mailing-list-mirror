From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Simple questions on GIT usage.
Date: Mon, 14 Nov 2005 17:36:08 +0100
Message-ID: <cda58cb80511140836i41d496e1u@mail.gmail.com>
References: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhJV-0003cR-QV
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVKNQgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVKNQgK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:36:10 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:12181 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751166AbVKNQgJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:36:09 -0500
Received: by zproxy.gmail.com with SMTP id 14so1317855nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 08:36:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZaZT4OlD6BMa/N+zsi/+RK2yW52hTVFDudPrBkDXxFoATJRXGSJyIw+HVGo5md8T2Lrm3Vg9PpEA+F1v5G5IzJ6bRfzrMiwN6wxqBWqayOF0g7DFp+7f/iGeALlA2okyCTvulRhAYwwMq4TkXp1ibroSxNczGgK+6Kos7MLSQQM=
Received: by 10.36.129.12 with SMTP id b12mr2252885nzd;
        Mon, 14 Nov 2005 08:36:08 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 08:36:08 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11811>

Andreas

Could you cc me when you're responding to my questions since I'm not
subscribed to the GIT mailing list for now...thanks

git-branch -d option is not documented on online documentation at:
http://www.kernel.org/pub/software/scm/git/docs/
That's why I didn't find it by my self...

Regarding the second question, your feeling is wrong.  What you
described is well documented in the git tutorial. There's no "hidden"
question behind the one I posted in my first email. So the question is
still: Is there a way to get information about the working repository
? For instance if I create a branch which is not based on the current
HEAD position of master branch but instead is based on a previous
poisition of master branch.  Then later I want to know how I create
this branch, how can I get this information ?

Thanks
--
               Franck
