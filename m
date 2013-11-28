From: John Collins Sunday <johnbendie@gmail.com>
Subject: git paging output
Date: Thu, 28 Nov 2013 22:58:38 +0100
Message-ID: <CANA3ovn6QGFZ7ohPOStGUT=63J1Wpmf2dPCWw+dcfeZfGaNGYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 22:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm9bg-0006Mj-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 22:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab3K1V6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 16:58:41 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:55166 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3K1V6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 16:58:40 -0500
Received: by mail-we0-f169.google.com with SMTP id w61so3034051wes.28
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 13:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nyeVq8oFD3u92Q90wpG+I19OuLzYznWFODe+k9TLLyA=;
        b=rt/wnrqTzYWmceCj0uP8KJS3gX77u3QaZhoJxdLgBRRKe/9BKL0iZSe+fGZDl+flfF
         00165ap5g9Fv5IFiH/i+JmTRIbsVNgU2IFnF1W+g2D3bm55YZJI+j3wg0bc/D3m86cIg
         QMIn0vslfgJpjxAvbutpdARNcZ93KJhAwnjb03gs5DRv0oI7pLhE7CRKVqEnjhsfXV/v
         Vwg/SmE5SgYZBNVhkGCvzYTFfMVh2kRYW7sLdH2U0fmRe0wrnAEqLdyF6Askqwb8hWS0
         9VB6dBW21ampPJ1xKWuIKHz43ITrVOXuG4uaapKq7wNW9zhYxh+w+pxd4Cxj1PFqtzCW
         N+Ow==
X-Received: by 10.194.240.129 with SMTP id wa1mr38356564wjc.31.1385675919036;
 Thu, 28 Nov 2013 13:58:39 -0800 (PST)
Received: by 10.194.155.71 with HTTP; Thu, 28 Nov 2013 13:58:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238517>

How can I make git to use emacsclient for all output? I know that setting
core.pager to nil makes it do full output but how do I push it to emacs?

John
