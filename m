From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-scm.com refresh
Date: Fri, 04 May 2012 17:26:07 -0700 (PDT)
Message-ID: <m38vh7qxs3.fsf@localhost.localdomain>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 02:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQSpF-00012c-BQ
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 02:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429Ab2EEA0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 20:26:10 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62969 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab2EEA0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 20:26:09 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so233212wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CkjwTyOXVXR0XAjiC9tdYN9HPZMQDz9+SpppKbnUq0I=;
        b=UbMFaY+DlI10p2NPJGxwBbOFm1LCAv0g3Kcd5WohIFvI62WVh8aeeLgBlphzBPJ4LF
         LQbvXrb0krBgg7H0M5JomxSN8mv6QHM65QqjOEd+hxmdlK2sZBLTJ/A4FnKbLV4p/o4e
         Z3h51HGLJUCc0/Rgb3Z3sfpLy7UAUG5xuy3qTetKRU+kMaq6FYT/tdm+14G2+9wieRLN
         9xqp0cmYYtV6zO/k69OaoxxA7g+xVKqRui8La8gk9tZUA82yCTkMbhtqBUTvSq6yqQsz
         tUA/tf+oiS6G0LZN11eQj9XsYsYwgsKPFMiL7GOvhiDdZqXw+4D9FOCrsrCI35HFw2MM
         obUg==
Received: by 10.216.136.131 with SMTP id w3mr3316694wei.15.1336177568117;
        Fri, 04 May 2012 17:26:08 -0700 (PDT)
Received: from localhost.localdomain (addh252.neoplus.adsl.tpnet.pl. [79.184.59.252])
        by mx.google.com with ESMTPS id f19sm2175456wiw.11.2012.05.04.17.26.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 17:26:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q450Ph1U026915;
	Sat, 5 May 2012 02:25:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q450PWr1026910;
	Sat, 5 May 2012 02:25:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197084>

Scott Chacon <schacon@gmail.com> writes:

> Hey everyone,
> 
> I just shipped a big update to the git-scm.com website, incorporating
> tons of feedback I've gotten on the site, especially from new users,
> over the years.  I think it will help new users to Git find the right
> installer and get up and running easier.  I have other ideas of things
> to add to it in the future, but I think this is much better than the
> site that has served us well for a few years now.
> 
> Some other interesting things to note:
> 
> * There is now permanent man page hosting here, for example:
> http://git-scm.com/docs/git-fsck.  You can also reference any older
> version of any command: http://git-scm.com/docs/git-fsck/1.5.5

That's very good.  Thank you very much for giving home to git manpages
online.

It would be nice for those manpages to have the title of page to be
set appropriately, e.g. for http://git-scm.com/docs/git-bisect to have
"git-bisect(1)" or "git-bisect(1) Manual Page", or even perhaps
"git-bisect(1) Manual Page - Find by binary search the change that
introduced a bug" instead of just "Git".

> 
> * We designed a new logo[1] - there are multiple variations available
> for download on the site under the most permissive CC license for any
> use.

IMVHO it is too similar to Bazaar logo:

  http://bazaar.canonical.com/bzricons/bazaar-logo.png

I like the [---] git logo, but I guess it is a bit cryptic.
           [+++]


[...]
> Let me know if you run into anything or there are any features you
> would like to see.

In my ancient 10-years old web browser (Mozilla 1.17.2, Linux) the new
layout is seriously broken (misaligned), and much less readable than
the old one (BTW. could you keep the old one, perhaps only the front
page, for comparison?).  Also the font size is too small.

-- 
Jakub Narebski
