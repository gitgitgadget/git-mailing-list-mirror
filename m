From: Grant <emailgrant@gmail.com>
Subject: Backlight control broken between 3.6.0-rc1 and 3.6.0-rc4
Date: Sun, 16 Sep 2012 02:30:05 -0700
Message-ID: <CAN0CFw0p1g23b5vCVAaVYLeb7YkngoKmptRcB5ud-gx3PpZjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 11:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDBBC-0005a8-L9
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 11:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab2IPJaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 05:30:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35307 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2IPJaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 05:30:06 -0400
Received: by weyx8 with SMTP id x8so3277429wey.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=d5xJF2bKJ60Bfvovs3M7ufdP+fWDQqpg7oLf0LP4XGc=;
        b=a+Jbz2vNgdqNqLkUHpwxtAEN0BuoCYH035AmauoA27rvxbGNYVJDEo+B8IrINcR3pR
         M8pRr2CoRnNvV2BwmkclglURpDVnM9L/plZk+tA+R7KvryvsSKRzR70zNyJ+KRSmeD61
         oPqJpa5vMbRUQwxs8FFSdfgL4Aq6j0sqENCLd+SVEz0hg5yp6oQ6LCFywvogJmuq/52j
         imXZRWKTAbbndkeEY3Z20p5yLIoXirCkHFuWmWkAI/qjr4Jb+WJZGgStKg16274nh3BC
         SAhvsuYEWXOKr4ueqkWm3KUncsvlFd+e2EnbwTCVkCJTvhWDksYNfLoRJy1FxeVlfCLb
         7IfQ==
Received: by 10.180.105.6 with SMTP id gi6mr9015274wib.4.1347787805581; Sun,
 16 Sep 2012 02:30:05 -0700 (PDT)
Received: by 10.223.76.5 with HTTP; Sun, 16 Sep 2012 02:30:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205601>

I have a Dell XPS 13 Ultrabook laptop.  Backlight control used to be
broken, it works in 3.6.0-rc1, and it is broken again in 3.6.0-rc4.

- Grant
