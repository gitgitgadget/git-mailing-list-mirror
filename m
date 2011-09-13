From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Status of git-remote-hg
Date: Tue, 13 Sep 2011 17:35:36 +1000
Message-ID: <CAH5451=aYft1QoTdKA=iiLxw+OLqE8bGvd5j_UoP0Jmufc49eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 09:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3NYj-0001kq-J9
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 09:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab1IMHh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 03:37:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40069 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab1IMHh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 03:37:28 -0400
Received: by fxe4 with SMTP id 4so349156fxe.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=QXJjwuY+8tqgPd+urxytn4sc0dvqKNMaHs7N/2Yg3hI=;
        b=MuFeUJezzRSSwvB9DBBY7JmkYeoqm+1mLuER2aFf9smTryqKjxxQEtk9DzJ6WJ8Rnd
         1VOcq5Jk/LpUktW34k5OMvpuSMJBuHMOiU0c0x/IxQ7MnY4LXjBkN4H5c7u2R4Up4lNX
         8IiTgluaGppg3CERkgPxcq8gK9vpRhKivxZfQ=
Received: by 10.223.49.139 with SMTP id v11mr1205295faf.21.1315899336475; Tue,
 13 Sep 2011 00:35:36 -0700 (PDT)
Received: by 10.152.1.161 with HTTP; Tue, 13 Sep 2011 00:35:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181270>

Hi there, I can't seem to find many references to git-remote-hg lying
around. There were some commits by Sverre Rabbelier
(http://thread.gmane.org/gmane.comp.version-control.git/154669)
preparing for it, but I couldn't find much else.

I have been looking for a way to use git to directly interact with
remote mercurial repositories, however I can only find examples using
hg-git and hg-fast-export. These feel clumsy, and I hoped the
git-remote-hg work would make them unnecessary.

Any news on that, or tips in general would be appreciated.

Regards,

Andrew Ardill
