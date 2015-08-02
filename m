From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Draft of Git Rev News edition 6
Date: Mon, 3 Aug 2015 00:52:13 +0200
Message-ID: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 00:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZM279-0005jS-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 00:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbbHBWwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 18:52:15 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35897 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbHBWwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 18:52:14 -0400
Received: by wicgj17 with SMTP id gj17so81769885wic.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=dLJ2ffxt95s4vF1ZJ9yCnLQnUOgv5nUf9y5PjCy77Zs=;
        b=UJa1q0CWcj+/CNVyN9xEze17Vt3yeibj2ilBLQQa1rNcPhYK6xkt69CyRkPSlUU24D
         Dz0I07sE7eAqbbJJf/L5w8MyUEfB757MmxIzwxY43rBVwpWkWTxfw53cugGJ2g/J1rul
         7OHvPvN7r9GKRt53cR2LxwY+pWd3PJ4p+qMOvG+/5SjOdkKiBomMxiLdfj141JJUjAQC
         Y6+B3jC3teMy6Bk5tyE33g/slYp1LlDYZUur+Q6FN3JKA+ONzf9DoZEVPh7/U8Un9I1l
         tESz6tcXi4f/cyNaKki4+sxueI0iadjuy6scxU4/scF1jkm/znkoBrNqMDO786PWWjBV
         AueQ==
X-Received: by 10.194.90.171 with SMTP id bx11mr26854788wjb.129.1438555933252;
 Sun, 02 Aug 2015 15:52:13 -0700 (PDT)
Received: by 10.27.47.137 with HTTP; Sun, 2 Aug 2015 15:52:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275152>

Hi,

A draft of Git Rev News edition 6 is available here:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-6.md

Everyone is welcome to contribute in any section, either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

https://github.com/git/git.github.io/issues/89

You can also reply to this email.

Me and Nicola are planning to ship this edition on Wednesday 5th of
August (as Christian C. is away on vacation these days).

Note that I did not cc everyone involved in the discussed threads, which were:

* "git log fails to show all changes for a file"
* "Git tag: pre-receive hook issue"

Cheers,

-Thomas
