From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 0/3] l10: de.po: fixes around rebase
Date: Tue, 19 May 2015 18:26:43 +0200
Message-ID: <CAN0XMOKq853gzzMp15GGOd9kONs2aGfU3pz_VA7Xm7zBVFzXBA@mail.gmail.com>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 19 18:27:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YukLx-0007dl-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbbESQ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:26:45 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37002 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbESQ0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:26:44 -0400
Received: by wibt6 with SMTP id t6so29271765wib.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iIZa2tjIf8H3Qreb2QSpIlylkeBHrOPmwuTrsFwngPk=;
        b=uz/UgfHCfCxytYuU0k0w03/FOKxdlzsx8TGs/VTFBxpIDDFYgvVQrx/REaCd+jK2p6
         phIiS/qynBEB0nQOg53O+uo/baqfgylHEpUesNkAehf9tQa3nkmoAVnUKGwTjpzBuSUr
         TQ3s0PnDyQyG1FN3WgYPhqZ1WYJxTOo3iscI6yNWr8Suw2ktiaJxFsdaL7ZMxuibEDl+
         ZGZ7G6WWp9c1R27gfnMALTqJpqzmJJrCpEpY8ayjWhpCpO9zgi1Qh4l+m+HSrFydD6VJ
         ZDYW8YfcZS+jQ8Qva+uUTHQKxhG+b0wIYRdn/QMk5s4yBDKKmKstpNUbZuYMKngVq6O3
         eK9A==
X-Received: by 10.180.188.170 with SMTP id gb10mr33702275wic.39.1432052803386;
 Tue, 19 May 2015 09:26:43 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Tue, 19 May 2015 09:26:43 -0700 (PDT)
In-Reply-To: <cover.1432025365.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269369>

2015-05-19 10:51 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Fixes to a few issues that I found while running rebase
> in German locale.
>
> Michael J Gruber (3):
>   l10: de.po: grammar fix
>   l10: de.po: punctuation fixes
>   l10: de.po: translation fix for fall-back to 3way merge
>

Thanks!

>  po/de.po | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.4.0.rc3.332.g886447c
>
