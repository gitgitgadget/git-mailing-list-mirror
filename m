From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-scm.com website (was: Promoting Git developers)
Date: Mon, 9 Mar 2015 08:51:02 -0700
Message-ID: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:51:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUzxp-0007ge-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 16:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbbCIPvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 11:51:25 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34733 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbbCIPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 11:51:23 -0400
Received: by yhaf73 with SMTP id f73so12041664yha.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=4jcuK+02N2ecsz0CchHYKtYF4SYJIrF+fkzQ2kdsc+E=;
        b=WNCNxQAJUlo8kxRGq0+/eh4BGAhUNZSe3B5DSzW7mm0f8rK58cdu3f2keb/hFtVhwz
         Td+NxKPHLnckjroQchHS3NYdhOdrJhBvB0D5x4LClfFeQPy8I0iX5PbPv6ZjNZdKj9h1
         c8GcfL5MwvUnI8S9uPS83JZ6Vv+Ktr93att0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=4jcuK+02N2ecsz0CchHYKtYF4SYJIrF+fkzQ2kdsc+E=;
        b=aSQuaMEr5RVgRMZq13EtDsCHgbVhILfrGgVpCcSuqJpOCue0OpELYGnJwSu6zdug48
         rTX26dHhc5159WNYkKWHtCJ3q1JmzufR7smmQTUjgh9OO9x9CqhIZ1ijLyA8ZeXWok64
         7GauPkaphsCOVnKvqW0VluzQPUJ+zvfXM2P9dvrVGun5FjoKWMXwGhjn0DI4u7st+6jY
         DkP29BDYBJDlrtXuXAt6038/EP7g1RNrDUTgcPRQGgU0jq4qyfmcNp3pBsyUCSXoQa0p
         MeJ21+XzujC0O5ucD3Rv1UNR7+URYqswzub+mKYtXAQ3jPv3Ex+lanlripMcTBgvkBDn
         liig==
X-Gm-Message-State: ALoCoQnloFCEhC2IWezsu4+55HZcpGdo7O4eAgKT4MweTff04GCBfZHiqar0qLmtMVZhth1KQFg9
X-Received: by 10.236.4.138 with SMTP id 10mr26949580yhj.98.1425916282841;
 Mon, 09 Mar 2015 08:51:22 -0700 (PDT)
Received: by 10.170.39.19 with HTTP; Mon, 9 Mar 2015 08:51:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265172>

On Mon, Mar 9, 2015 at 6:57 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Since we're talking business: git-scm.com still looks a bit like a
> ProGit/Github promotion site. I don't have anything against either, and
> git-scm.com provides a lot of the information that users are looking
> for, and that are hard to find anywhere else; it's a landing page. It
> just does not look like a "project home".

Yes, git-scm.com is a place to point people.

Before it was created by Scott Chacon (and others) there was no
landing page for users looking for information on Git.

After it was created, nobody else stepped up with a better alternative.

Writing a website is hard. I have been struggling to make a better
landing page for Gerrit Code Review[1,2]. I really do understand why
Git C hackers aren't interested in sitting down to write prose, HTML
and CSS.

Many of the folks that have contributed to git-scm.com don't usually
contribute C code, but their contribution to the project has still
been beneficial by providing a landing page.


git-scm.com is controlled by the Git project through its membership
with the Conservancy. It could be redirected to another site if
another site existed that better served end-users and the project
better.


[1] http://code.google.com/p/gerrit
[2] https://gerrit.googlesource.com/homepage/+doc/HEAD/
