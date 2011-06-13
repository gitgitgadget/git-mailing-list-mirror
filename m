From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Let's make our cycles shorter
Date: Mon, 13 Jun 2011 02:45:36 +0200
Message-ID: <BANLkTim4STXM-r0aujsmu4YeJ9WLt+Y_VEvZ_rG5PEqLnAAq6Q@mail.gmail.com>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org> <7vvcyyhq9q.fsf@alter.siamese.dyndns.org>
 <BANLkTinzXLK0dHYjBMpBgLqZ_7KNHeu3uA@mail.gmail.com> <7v1v0ql0uw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 02:46:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVvIS-0006Sa-TU
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 02:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab1FMAqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 20:46:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52022 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab1FMAqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 20:46:23 -0400
Received: by vws1 with SMTP id 1so3300890vws.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=o6GSOibwQKy7qMmFK1TMEDqokSWCz1eHWh1O4taTaTk=;
        b=Zw21HAnQS1doIg8X7c0WT8LEuLgMZIg2Zzjd2IYxQN6++0wgcxjJbYU/srJC6vIrn/
         V44EGO5eoIsKLyPqfl9o9tZrw+qIihQVLIwTu/iOa294vYJsty+JljRB/BZAB/xW9Xmq
         h98B2mraPZgf1fYCBxb73D2skBQYvg6I8BXpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qOVJaUyB+FdcOWEHzhmXmAvBcJcOBE8HTCo67kbLK7KCvuCSellGG2pVXeENvUg2Ck
         8DvDQ4AWEnVcBASRqlsk7bZEv0d0qlqOcOCtAgZTNTNy/fouEeaZdWyFp5DlkH9Zc2+i
         5R6/PYvso+iSmtkslWEfbQCGBn+uOmmu9HIoA=
Received: by 10.52.95.67 with SMTP id di3mr2549405vdb.196.1307925982560; Sun,
 12 Jun 2011 17:46:22 -0700 (PDT)
Received: by 10.52.114.194 with HTTP; Sun, 12 Jun 2011 17:45:36 -0700 (PDT)
In-Reply-To: <7v1v0ql0uw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175674>

On Mon, Apr 25, 2011 at 19:03, Junio C Hamano <gitster@pobox.com> wrote:
>> I was surprised to not read response, it's having sensitive impact on
>> the project.
>
> Hmm, what sensitive impact on which project do you have in mind?

Short cycle means less time to write code for the next release, the
"frame" to add feature is reduced. I'm surely wrong, Git is a stable
project and well managed (with 4 branches: unstable, integration, next
stable & stable).

> I just spelled the structure out for the next cycle, and tried to give
> some predictable bounds to that elastic development stretch, in order to
> force myself to stick to a schedule in which we can make measurable
> progress in reasonable amount of time.

Cool :).


-- 
Sebastien Douche <sdouche@gmail.com>
Twitter : @sdouche
