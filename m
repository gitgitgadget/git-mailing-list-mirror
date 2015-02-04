From: Matthew Brett <matthew.brett@gmail.com>
Subject: Advice on edits to git-rebase man page
Date: Wed, 4 Feb 2015 12:21:14 -0800
Message-ID: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Reuben Thomas <rrt@sc3d.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ6SC-000621-3G
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 21:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161613AbbBDUVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 15:21:35 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:59177 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161552AbbBDUVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 15:21:35 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so1688991yha.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 12:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=FCqT4lWb1ljjosq0Bj83Hk/96GglN8IiSCgNDlAH4Bg=;
        b=SzxicXxlvosfPlKIdOwXOxp6CEiKaS+zsqLltcz0Ew5BRITEcvWDA1lRdoeeATyeuS
         l4vUADk5Hclu55uYgEF6QplM3WRu1N6PvO1MZdF1NFfoWmMqlPfVGOuDYr1zk84cltnH
         1Rmd5N/j0FenbqzfugX7IhZ723Ov9sCZuTTSTTpAgCkrnnw0ubu+xtxqqTaKeOjew6CY
         1vWOTjyYSh26BOP2A3lxWNlzrsGV4EWpjzp6SyqeBz4pMzVt3fQOobapqz2xYszrDLdp
         P/Z2Z2tp4Icb6+0GkESSsJGL31OPlMwClczF/M9Yuj0BcW+H2P7u/ecyqGDktYtzXXvE
         zewQ==
X-Received: by 10.236.40.100 with SMTP id e64mr13466322yhb.109.1423081294433;
 Wed, 04 Feb 2015 12:21:34 -0800 (PST)
Received: by 10.170.217.69 with HTTP; Wed, 4 Feb 2015 12:21:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263357>

Hi,

Sorry for the rather open-ended email, but I am interested to whether
you would be interested in patches for git-rebase man page, based on a
tutorial page I wrote some ago:

http://matthew-brett.github.io/pydagogue/rebase_without_tears.html

The reason I ask, is because I have found the git-rebase man page
particularly difficult to read for an overview of what it is intended
for.   A colleague recently wrote to me asking if I would consider
proposing merging my page with the git man page.

Obviously my page as it is now is very different in tone from the
git-rebase page, but I think there are some aspects that could be
fruitfully merged.   Would you be interested in patches of this sort,
or does the page seem too far from the intention of the man page?

Best,

Matthew
