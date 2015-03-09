From: Stefan Beller <sbeller@google.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 10:30:48 -0700
Message-ID: <CAGZ79kY_Kb63C6fKeHHx52sEn8j-Ho62-dh97-J8irhjGxaBqA@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
	<87y4n6kvdu.fsf@fencepost.gnu.org>
	<CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:31:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV1W9-00037M-06
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 18:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbbCIRax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 13:30:53 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44030 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbCIRat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 13:30:49 -0400
Received: by igbhn18 with SMTP id hn18so23380596igb.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UjorLYbfh9GGuxW8wSl2+A3DmHTCzfh5GBFrDKcBhVw=;
        b=me1vndTYn6Ps5405x/5gT2CfY/FRY4p4khrPZG5P1fCp6GXKDGhVCEl19x7OBKEGnf
         lxGxAOkzZTO2Sh5pT0wHrxwobVPZw3y7cczx6U9WL0DHrhidXAOZhxKmSex/FcFDelm3
         vp4KywdtQfzWOcKdgZkl/FTaeZMdKkLdrkmoL9VOs3YgWtloPRtngS8y4Maai4qhasi7
         2N0kYYDzvkCPg8G248D6RHY35X89db5jKsofKQSGjOSBvlkGWJ8az2nKRQ8Af53HQ314
         SJO1Eoc5wL2FBnr4rkM7ZPfZMhGEydGxHTLbVk2KKYEzQkyb1E2o26Cs7KtQoF6jqFIv
         dQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UjorLYbfh9GGuxW8wSl2+A3DmHTCzfh5GBFrDKcBhVw=;
        b=YRRxNGmkCHzV6mQmTBvEsz61VTQ0yL1RaqCpWTcTDXO44/uFEGazIeGuPflJppVx3l
         zehZy4ii/fO8KZvugI+KgGKhN2kCNsCncc0KeQtRAdLQszI5wzHENR+sLv+iDgZPA9JM
         0j92QyqxC8SBL5oMdgQ1iLmVaoR2qinEIyXE9hmQLYf/fVqkXIUgrpNUYBUG2x8NoNXx
         P35Now2keyvwFVwbCZ600XoCB9hg6Vw2g3WrfsVPBbFAXnm1Y39pL+GtUhcYLaPQbgkh
         eHgFc5d/moxJS5ylztfHlA2MMgp68i1AlDgqTlWDRa/rZrDVYe0BiV7+f98xxBHHl/Ut
         yZmA==
X-Gm-Message-State: ALoCoQnro7XMu+sCvSPPTGZSR4MNzon9/m/5n/XAWM3YwlSh1YGHILH8CeQZ5p110PK7xx1L/Pg0
X-Received: by 10.42.81.195 with SMTP id a3mr29172559icl.76.1425922248599;
 Mon, 09 Mar 2015 10:30:48 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Mon, 9 Mar 2015 10:30:48 -0700 (PDT)
In-Reply-To: <CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265183>

On Mon, Mar 9, 2015 at 10:14 AM, Scott Chacon <schacon@gmail.com> wrote:
> >
> > It might make sense to reduce this list just to "Projects" since those
> > are actually more tangible and verifiable.  Or scrap it altogether.
> Sorry, I disagree with this. I think it's helpful for people to see
> some important corporations that are using it, since many people
> coming to the page are doing research to figure out if they want to
> switch to it in their companies. It also demonstrates that these large
> companies are participating in the open source community and it may
> help them decide to open source internal corporate projects as well,
> which I think is beneficial to everyone.

Yeah I'd agree on that. I'd even go a step further and claim it would be best
to show projects and companies coming from most different branches of
business.

("Can I switch my business over to Git? Oh well only these internet hacker
companies are using it, I -as an air drier firmware writer shop-
cannot relate to,
so I keep using RCS.")

Also looking at the open source projects, most of them seem to me as
large-ish umbrella projects, so a smaller(?) project like emacs would be
huge win to show off Git can work well with all kinds of projects.
