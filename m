From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 10:32:54 +0100
Message-ID: <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
	 <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJQMy-0007ri-2w
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYA1Jc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbYA1Jc6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:32:58 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:52741 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759262AbYA1Jc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:32:56 -0500
Received: by py-out-1112.google.com with SMTP id u52so2327305pyb.10
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2FJqvPhQhqD43Xrfpdqpr42+d/OHAc2sCR2JGfs91eI=;
        b=Vj6TZDsqNryfuzGUbFqLvrakBUV/7/zVfeo2MpI2uBQvukc06VJ9bl3ofqEd5NPBcOb21LV4VejfBacjEYDa1Kroe11fmlK0IYq7sXEwvQdGhiU6fS9TWPP5yGDnA300JCxOX9WICIwbyAnCuLSpEjxiMyzrzGwijg0whv2bUpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wuHIr69YcEi0GTXc+uzOA818qKoWXJzw8yD5Wv1r1aSAOl6wFQpMZBC0glplgd8DDyF6ttaA8N7bEx7hn+vzgLv7Zj8IrQXXUCx7JBugDP+f3NvCqcOCxOjnVQFeXCYtK+hsIyV7gfYR99MFFZGpKB6711NhzRj+7fODmBj9JnI=
Received: by 10.142.163.14 with SMTP id l14mr2103897wfe.230.1201512774810;
        Mon, 28 Jan 2008 01:32:54 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 28 Jan 2008 01:32:54 -0800 (PST)
In-Reply-To: <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71869>

On Jan 28, 2008 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
> > I know ho to do the opposite process, rebase -i and squash is something
> > I'm really used to do but this time that trick is not going to help me.
> >
> > What is the preferred way to split a big patch in a series of
> > smaller patches?
>
>
> I personally found the procedure described there a bit on the
> sketchy side, but does "SPLITTING COMMITS" section of git-rebase
> manual help?

Yes it helps but I still wonder whether thereis a "simpler" way to achive that.
Is it possible to split a patch selecting the hunk in git gui or any
other graphical
tool?

That would be a good starting point for a newbie (like me).

Thanks!

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
