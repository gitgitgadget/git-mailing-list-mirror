From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Sun, 28 Oct 2007 20:44:44 +0800
Message-ID: <46dff0320710280544r7f99ddf7xfd5aa7cefb39a9fe@mail.gmail.com>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
	 <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
	 <20071028111443.GA29183@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 13:45:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im7Vl-0005RO-Qz
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 13:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXJ1Moq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 08:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbXJ1Moq
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 08:44:46 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34239 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbXJ1Mop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 08:44:45 -0400
Received: by py-out-1112.google.com with SMTP id u77so2300660pyb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=95L3ekoNzKvObExtz9HaBLN7y4v7hNYHNCM5l9paoUU=;
        b=rrJrJUvUUzvSrAkAc28fustbI+V1Z6Cwaqfdnm7ZSCDv3HSorwOjbODjB3KtbNyEw1jOZf87mWgIyU5b2T5K95emQBU6ZhLCxcrkGyi2Ow8Y90qt0uQOajME25ZNcP3P/92yF2l+eXtazAF3Xd5XGN0p8gplSi7a96elUeytUkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JtprS8jdUeh6X4ibhwwxw5BWO4nZPQ3bsjhf+iDrdAh2Yp97jRC8JgQ2qGYovgDsRgU+elAWnYO2bw7zVo0WHEy7o6fLbOOqxUytUrrlGlWm7p3KSqnm6rc2wEPn3SbjCerxGqrbGjRlnuDZgdzdfyZH1QhkCc4IaAiQrXdK8RE=
Received: by 10.35.90.1 with SMTP id s1mr6072394pyl.1193575484677;
        Sun, 28 Oct 2007 05:44:44 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Sun, 28 Oct 2007 05:44:44 -0700 (PDT)
In-Reply-To: <20071028111443.GA29183@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62559>

On 10/28/07, Peter Baumann <waste.manager@gmx.de> wrote:

> Have a look at the subtree merge strategy [1] and at the following
> explanations how git-gui got initally merged.
>
> -Peter
>
> [1]: http://www.gelato.unsw.edu.au/archives/git/0702/40139.html
> [2]: http://www.gelato.unsw.edu.au/archives/git/0702/39661.html
>

3x. I have seen that subtree stategy is introduced in commit 68fa.
However, I don't find any description in manual of git-merge. Should
this be added to this manual or any other document?


-- 
franky
