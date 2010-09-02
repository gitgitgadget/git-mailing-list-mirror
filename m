From: Pat Notz <patnotz@gmail.com>
Subject: Re: list all files in the repo
Date: Thu, 2 Sep 2010 16:01:09 -0600
Message-ID: <AANLkTinEXahB43aEtnK4JAp32d2FosSERMROcCV7E0Jk@mail.gmail.com>
References: <AANLkTinL2YFaXOzvLW7EOmhugKkxa2po4LyXZDObP7JE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Raymond Auge <raymond.auge@liferay.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 00:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrHqq-0005mP-QG
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab0IBWBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 18:01:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39529 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0IBWBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 18:01:31 -0400
Received: by fxm13 with SMTP id 13so677109fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/pB40KlJlgBtKRbLFyEvqmLqKzEhv0Fk+Lll0oEkD/4=;
        b=ssBSm01eLrGfMHT99w+iJQGt5AvrvRvQkuCIMfvgSSQk+CMc4VkdXOsvCtTRzB/aoO
         Be3m+pxHUOqhU8a7e9mDTmrIKuelkyA1rSmOeJ50Sf70NzYmFByo0cuTvHLWjPU727B9
         JWmJAAMaxmA7BOYXZKgjVgvaef/wpXhOsVVVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wXKId/FomKQ0uKbOZ5GndQUAkONL+D3mAJRqroV+UdZUebGnYwZwmGy8x8v28Fu8Vo
         UbpCtXv6nAsh1+cP2zEBN7jNLccjC8W2a4YfnQ1UIQy/Q8yVTuGKwvpytAGj10OeGm9x
         CNIHwIwlDVOEqhmzk7adG2AgTkCFAeiGcgaTQ=
Received: by 10.239.190.6 with SMTP id v6mr659913hbh.44.1283464889240; Thu, 02
 Sep 2010 15:01:29 -0700 (PDT)
Received: by 10.239.135.72 with HTTP; Thu, 2 Sep 2010 15:01:09 -0700 (PDT)
In-Reply-To: <AANLkTinL2YFaXOzvLW7EOmhugKkxa2po4LyXZDObP7JE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155213>

You might be interested to look at GitStats:

http://gitstats.sourceforge.net/

Checkout the examples directory:

http://gitstats.sourceforge.net/examples/

~ Pat

On Thu, Sep 2, 2010 at 3:34 PM, Raymond Auge <raymond.auge@liferay.com>=
 wrote:
> Hello All,
>
> I'm wondering if there is a way to list all the files in a repo, and
> include the last commit date, so that I can produce a histogram of th=
e
> repo.
>
> Thoughts?
>
> --
> Raymond Aug=E9
> Senior Software Architect
> Liferay, Inc.
> raymond.auge@liferay.com
> --
> Liferay West Coast Symposium
> Sep 08-09
> www.liferay.com/wcs
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
