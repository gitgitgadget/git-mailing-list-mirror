From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Single push for internal and public repo
Date: Mon, 30 Jun 2014 12:34:54 +0530
Message-ID: <CAD6G_RSHYWbsBfqrE4tPDunApZ-75DO1z=2KxLvd3ZYy=66n7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:05:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Ve7-0004O0-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 09:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaF3HEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 03:04:55 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:47046 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaF3HEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 03:04:54 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so4584068yho.18
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HhcWts+D7QGNgEIW42yJteMR+yHuGDAhptWbNk6YQzM=;
        b=ZzWX0GWDLJTZ1KaI1yArBVhT+Z+m5AIfOZSkb+3E/cCntzmnJBlxxuUkgQY8E/HizT
         8RMyNpvry4k8SmKN4nfVzhPJBgRpq9hIZbBkZ1fREU/X/DYvxLGzXLNXmsXLnfcG/Ru5
         VAyF793P+3a3nRz5EH1FAaTa44AuJCWVQW/3oFThsgMJ0Fslx/MmyhRzVvLv/LNKv2MM
         ScyIdAN03vfVBhfkPp5dlk5faCWgN2C3lZObay246qd+/LReZ29cHrQCEE6bQjZAD2Q6
         YFmgIUY8gKKBZo9aBzQBY4GCiX8ye6oavv5iucZCwcIU59W28mUGtngs2iuLHgOdYBn9
         zvmg==
X-Received: by 10.236.208.33 with SMTP id p21mr56250117yho.17.1404111894050;
 Mon, 30 Jun 2014 00:04:54 -0700 (PDT)
Received: by 10.170.187.84 with HTTP; Mon, 30 Jun 2014 00:04:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252658>

Usually will do
$ git push <repo> local_branch:destination_branch

repo - could be internal and public remote repo.

Any command or modified git push will do a push for internal and public repo's

Let me know If I'm unclear.

thanks!
-- 
Jagan.
