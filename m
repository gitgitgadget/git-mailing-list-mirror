From: Tim Visher <tim.visher@gmail.com>
Subject: `git submodule sync`'s purpose?
Date: Mon, 19 Apr 2010 21:56:16 -0400
Message-ID: <t2sc115fd3c1004191856za23ef32m421697b98159bcfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 03:56:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O42hh-0002Tp-If
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 03:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0DTB4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 21:56:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41223 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab0DTB4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 21:56:38 -0400
Received: by gwj19 with SMTP id 19so553496gwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=C0QexL0w0R407PD4YWwt02R14xMGlfI24IjdGqayoZk=;
        b=iUzzUfSrVmLF9B0e/PbtevUqrw41MDtnPPHGKhrufgeugZrqtTGjnXvS4hkq3HzpZP
         AbPLkdJQjZnmgyaV6E0luvaRCf67diUP94MHkGwmYL8BZ93E/lZpjEvRWatA+Y+wZ8my
         c+2RvBbAp2WOd8YchKaGMors5AhPqgTswMGuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=nG+Idsk+QNxS5EiEv0hF1hYwfrsf9AlfwrfhLRWyqXDyYgsTUazB+DjqXMM5wXzaJT
         HrJnGiUZdfOj+5iuAWbj0AVVChYkXRyDY/JcC37adsh56m+vJapY8j4MG82AVLCO+lDb
         MnVIS2Jv0vzuHjcykvvJUTcdAPe0AAXCVWONQ=
Received: by 10.100.109.4 with HTTP; Mon, 19 Apr 2010 18:56:16 -0700 (PDT)
Received: by 10.101.167.36 with SMTP id u36mr14934175ano.171.1271728597275; 
	Mon, 19 Apr 2010 18:56:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145347>

Hi everyone,

trying to understand if I'm just failing to parse the docs for `git
submodule sync`.  I'm basically under the impression that I can edit
the .gitmodules file by hand and then use that command to sync up my
submodules witin .git/config to that value.  Am I totally missing
something?

An example session can be found on [pastebin][].

[pastebin]: http://pastebin.com/chEdc2u5

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
