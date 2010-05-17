From: matteo brutti <webmbackslash@gmail.com>
Subject: git pull
Date: Mon, 17 May 2010 23:51:50 +0200
Message-ID: <AANLkTimLZgkojC5L0ZdDewhprLgehLw2w4EZDwyViF4R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 23:52:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE8EA-0002Wy-Be
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0EQVvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 17:51:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52129 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0EQVvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 17:51:52 -0400
Received: by fxm10 with SMTP id 10so392089fxm.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=S9Ngcm3ql2HpfAsvYlCXCDlSXBRed6FiC9iZ4yaKM7Q=;
        b=rCo5o3jDAOU0mfjB3KEd9gVuWSeT3igzhDIh5BkV5JNb9qDRJLRA+Wb+lNOfEYZsli
         sYH2dHWUEozw53yvsfOGQ/9PQnMyjddo8vpHt9/8vXNDIZKZLdQKN39NOGKfjiRyaavE
         pTgp1f1jJdfzR1/XuT80XEz/LPEZAVZoTVlIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iQbpwhO/6ZS1sPRrLgt3ZlvksUoB6sjuTdWj9mqOrC9bP8l8w5yacaUqO5SikfBOU/
         xdgQALRsn9wgBiIEWf9jgN/D5mnTxpEIP9I/F0v2LyL0P5cLibWCZnYwjw651vjffD1V
         DDrYCHQsG96Li6vxMaaNDNg8Os7iZVdSn0OZ4=
Received: by 10.103.84.21 with SMTP id m21mr3925647mul.106.1274133110820; Mon, 
	17 May 2010 14:51:50 -0700 (PDT)
Received: by 10.103.137.11 with HTTP; Mon, 17 May 2010 14:51:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147260>

Hi,
i'm learning about git and soon have a question.
My repo is in /dev/sda6 and my home is in /dev/sda4, as are both in
local i thought that when i committ, i'll found the files on repo
changed, it was not so! I learn i have to use git pull, but i didn't
understand why.
I made some tries, put my repo in /home/user/myrepo cloned in
/home/user/myclones changed files and committed and the changes was in
the repo without any need of pulling, and i have permission to write
to /dev/sda6, so why have i to pull changes?

Thanks.


Matteo
