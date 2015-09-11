From: Renato Akaboci <renato.akaboci@gmail.com>
Subject: error opening "git gui"
Date: Fri, 11 Sep 2015 13:48:58 -0300
Message-ID: <CAF2U6N0HzgWK-4D2Ednt46u_R+eL2-2C9g9GpczyAvj+pKv-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 18:49:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaRVq-0007Zp-LY
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbbIKQtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2015 12:49:18 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36262 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbIKQtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 12:49:18 -0400
Received: by obqa2 with SMTP id a2so65198710obq.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=v76f4TuIWxqj2WUllAs4O0H6mBNsZZYqyzUEuHEw75E=;
        b=J/eV2gI6LKExxS0jCB8f3zjBw9YqT1emamIKrFMlX3SDf8rTiTfV7UgFJRtwQQFnHL
         GLnoDYvAIjQ+3UWyC/nslTaKxb3YkvNITXHkQ8Iz6MTfiOpKX683DHtFk7a7xrW4A71h
         k7e7KyfEKhItfwC4pH9wnOfmBBHRssFV7Q3Tk+D7SvLCIqHtP4uxTed7p0XWhG1wfVdh
         GK2qkrGqjKdl56baRFdcf8dHRQH6i9VEfkrz4m+u8XUmATa6GTa7I9FNJpqwH2s2Xl7o
         n99hJBoue42JBYBdOqzkNP2C6m8K6oUgCRfpRAzczZ7OYJUYJfzMn2l0l0cJvucPacXj
         P4Xg==
X-Received: by 10.182.39.194 with SMTP id r2mr40126693obk.20.1441990157835;
 Fri, 11 Sep 2015 09:49:17 -0700 (PDT)
Received: by 10.202.198.17 with HTTP; Fri, 11 Sep 2015 09:48:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277682>

Hi,

I=C2=B4m in trouble just after installation of my Git for Windows.
I get a box with error saying:

couldn=C2=B4t read file "C:\Program
=46iles\Git\cmd\mingw64\libexec\git-core\git-gui": no such file or
directory

I=C2=B4ve just installed git as normal. Git Bash works perfectly, and i=
f I
call "git gui" on bash or cmd, it open. I guess that is something
missing on my machine, but I don=C2=B4t know what.
- My Operational System is Windows 10 x64

Any advice will be appreciated.
Thanks in advance
