From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git-scm.com refresh
Date: Mon, 7 May 2012 06:18:10 +0200
Message-ID: <CAP8UFD0SX30rBV0jAvogLeZgS_0_WDMYTBhkkC4T5_17PO-MxA@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 06:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRFOr-0001Nt-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 06:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab2EGESM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 00:18:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52047 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2EGESL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 00:18:11 -0400
Received: by dady13 with SMTP id y13so746877dad.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Fh2GwPNaHhfnHqKYpLgruqwym+HP5bldkafXXKGnvA=;
        b=Q3snjMnkMpEbQrf7kXjvkDAH9IKNo+Vum918cZR0hqTxEBgd6xe8DFa8QBcpmCPy4D
         G6xswVJZAjEeHyFDBbHqvhi1LDvjmY617++2SDu/cLRRCN149cR1Z/8gWd4tw8ZdVC6d
         Wga7RPa/liMdP9/RIP0qKFkxFurnL/kL2dOOY3HcXKLs8v+HPs7y6I34YMZ3Va/QrbDo
         FmXxLUFBvfM/m3Npvp8sc6DHg7WdXrkp4WsdFFFFadxJdaZjHCH+dVgbWth9pOlSbAbq
         DVisqs9Ra5LgEoKhRa1CFIqM+c2GTxF0bCEKFkaBQptNNDO9f4+a4lQp4RhAySKSLOid
         g4AA==
Received: by 10.68.200.74 with SMTP id jq10mr30846214pbc.66.1336364290578;
 Sun, 06 May 2012 21:18:10 -0700 (PDT)
Received: by 10.142.143.13 with HTTP; Sun, 6 May 2012 21:18:10 -0700 (PDT)
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197234>

Hi Scott,

On Sat, May 5, 2012 at 1:29 AM, Scott Chacon <schacon@gmail.com> wrote:
> Hey everyone,
>
> I just shipped a big update to the git-scm.com website, incorporating
> tons of feedback I've gotten on the site, especially from new users,
> over the years. =A0I think it will help new users to Git find the rig=
ht
> installer and get up and running easier. =A0I have other ideas of thi=
ngs
> to add to it in the future, but I think this is much better than the
> site that has served us well for a few years now.
>
> Some other interesting things to note:
>
> * There is now permanent man page hosting here, for example:
> http://git-scm.com/docs/git-fsck. =A0You can also reference any older
> version of any command: http://git-scm.com/docs/git-fsck/1.5.5

Great!

> * We designed a new logo[1] - there are multiple variations available
> for download on the site under the most permissive CC license for any
> use.

I prefer the old one.

> * The Pro Git book (and all of it's translations) has been directly
> incorporated into the site and has better permalinks and section
> anchors. =A0progit.org will soon be redirecting to git-scm.com.

It's good to have it integrated but on the other hand I don't like the
boxes on the left side of each page about the book.
It just looks to me like an (annoying) ad.

> * Matthew McCullough has started a video series[2] for newbies and
> will continue to do more developer and intermediate type videos as
> well.

Nice.

> * There are still a few asciidoc parsing issues that we're working on
> - if you find anything that's weird please report it at our issue
> tracker: https://github.com/github/gitscm-next/issues
>
> Let me know if you run into anything or there are any features you
> would like to see.

I would like the page about the git authors to be back.

Thanks,
Christian.
