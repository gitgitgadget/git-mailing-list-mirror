From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: zealous git convert determined to set up git server
Date: Thu, 15 Sep 2011 04:38:36 -0700
Message-ID: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 13:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4AHC-0006DS-UT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 13:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271Ab1IOLii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 07:38:38 -0400
Received: from mail-ew0-f43.google.com ([209.85.215.43]:64983 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075Ab1IOLih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 07:38:37 -0400
Received: by ewy20 with SMTP id 20so1712785ewy.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k/iOWsFmiSMLyirLdLNyO15ZYTymGKC0j88qQGaaDgE=;
        b=KO463ABW+GPukeFZp+D0fe/iuU5hvWNuLWAFWTGupc8dSu/14CSQ5Bsh0DghmLPYEO
         nEt/KanQMdAkqxUVXCNwZw2cn4pKQVpdgVM7JSIEOlUUMThTS9TYKfz5so61c1rEiLZl
         CHKbGRAIwtcJaiDCacnNAtxB6sfeD4/x9KBaY=
Received: by 10.213.16.141 with SMTP id o13mr378526eba.91.1316086716531; Thu,
 15 Sep 2011 04:38:36 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Thu, 15 Sep 2011 04:38:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181461>

Breaking away from previous conversation "Anybody home?"

2011/9/15 Jakub Narebski <jnareb@gmail.com>:
> I think that either "Pro Git" book, or "The Git Community Book"
> would be a best source to learn about setting-up git server.
>
> I think the simplest solution for git hosting management would be to
> use gitolite (there are other git repository management software:
> Gitosis, SCM Manager, Gitblit).
>
> If you want to host something like GitHub, there are open source
> solutions too: Gitorious, InDefero, Girocco + gitweb,...
>
> HTH
> --
> Jakub Nar=C4=99bski
>
>

I totally didn't see "The Git Community Book".  There's no link for it
where I was looking: http://git-scm.com/documentation

As for setting up a work station, I found a pretty good guide at GitHub=
:
Windows: http://help.github.com/win-set-up-git/
Linux: http://help.github.com/linux-set-up-git/

Question 1: With both "Pro Git" and "The Git Community Book", has
anybody noticed any major discrepancies between the pdf and online
versions?  I'd like to place the pdf versions on my mobile device for
travel reading.

Question 2: It seems gitolite is the popular choice for git user
management.  Any reason why?

Question 3: So, Gitorious is more than just a repository hosting
website?  It's also an open source repository hosting platform, which
powers the Gitorious website?  That's pretty cool.
