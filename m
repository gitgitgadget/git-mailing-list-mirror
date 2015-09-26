From: Alex Radulescu <mydesweb@gmail.com>
Subject: git commit -a -m is not working
Date: Sat, 26 Sep 2015 21:51:12 +0300
Message-ID: <CAMWrOy7YoAofbzfW+dy=v1TRgWGe5OuZ8U2x+Q-XCKc1y_agRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 20:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfuZ5-0002jZ-QC
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 20:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbbIZSvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 14:51:15 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33267 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbIZSvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 14:51:14 -0400
Received: by lahh2 with SMTP id h2so125662447lah.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZcHtfNHoJPFwSFrjFixjrobmoVsJBecXnWt6tMk2GkE=;
        b=Hj7F+R5X8fkNN4HcKGruBexDp3WvZMxpLN0FUnHkfpZpaC7z6g9g/KYCieJplxd+ID
         LesvXZBWO9kiY5HqUt8WJazi2kjpr6CBsN+PVts/It6+mpya2xUz2lyOwX37QbDhHf4I
         g3fYnLRH705gMer1NW+uPRo7dSpp2XqzbNHeD8zC3lWQF88G30yvMns+R87F5MICJubp
         +Xpx8mcEKWUUDjKHuDqOYUGCW0RusV6F+d5JvJKuAEFiIbGP9syDW603qW9L6mbGbn8+
         Kzlzrn0MONpukTd0mxx0FT+Whuqp4d293V3hZPM8RO/8gsAw+vto9/jTD4iu4kVhAlhz
         McHg==
X-Received: by 10.25.82.10 with SMTP id g10mr2256919lfb.56.1443293472729; Sat,
 26 Sep 2015 11:51:12 -0700 (PDT)
Received: by 10.114.25.5 with HTTP; Sat, 26 Sep 2015 11:51:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278696>

Hi,

This command is not working. Any advice?

Alex:testGit Alex$ git commit -a -m 'made a change'

On branch v1.0

Untracked files:

new_branch.txt

nothing added to commit but untracked files present
