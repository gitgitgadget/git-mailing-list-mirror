From: Sebastien Douche <sdouche@gmail.com>
Subject: French translation project started
Date: Mon, 25 Apr 2011 04:29:17 +0200
Message-ID: <BANLkTikTmDTP-1=NFSm=yOC-JirOEhF=gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 04:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEBZJ-0000x4-KP
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 04:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab1DYC36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 22:29:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43446 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017Ab1DYC36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 22:29:58 -0400
Received: by vws1 with SMTP id 1so1518553vws.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=gIxpfF8PY5yrdo3l+evQRGlEGyxI6kZTeT4yLcKP+4w=;
        b=Lxn+tHWuE0JI2x+NIQq5WZvCZskH++167Cf61wuWjPHNBmD27hrDtZhXRjUZ/Qu6nm
         moc12VusNr7f3OxEt9gXEjSndZiikOrCpr6IPK9yTahVZCmuF/J+Z+eJQAy/tCqwBZ+Q
         hQLWNuZcak1vbaqa5UmW/WcNrtEBBB8ZTywpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=HyZ8CaC1MdHowJsLPdeSg0Sf2fdHuIApCAhbxHFc9Z1lNaDl1M+QhZdM5Ogmj5RG7/
         b4EagdVYnBT9obQimmdYUSxlP03GLFmi+fMKeUOFbV69sRVJFIDOfm6aFVJuU4yD/mK2
         bns0Z+bcH7lDtsqxiI5UnZ+plnXQs8KfVyGAc=
Received: by 10.52.98.34 with SMTP id ef2mr3354566vdb.293.1303698597099; Sun,
 24 Apr 2011 19:29:57 -0700 (PDT)
Received: by 10.52.169.170 with HTTP; Sun, 24 Apr 2011 19:29:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172013>

I created a GitHub repository for the french translation[1].

Mini roadmap:
- Create an french glossary of terms.
- Review git-gui and gitk translations.
- First version of french core Git translation.

Any help would be most welcome!


[1] https://github.com/sdouche/git-french-translation

-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
