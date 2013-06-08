From: Sudhir Kumar <smalikphy@gmail.com>
Subject: Git exile Issues
Date: Fri, 7 Jun 2013 18:02:59 -0700
Message-ID: <CAFabFLZTW9nXj_5Y-Sq_vJQiygydez=_oC-2+4QHUrALtp9KeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 03:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul7Yn-0000Zl-Di
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 03:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab3FHBDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 21:03:00 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:64980 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FHBDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 21:03:00 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so7467437obq.35
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=E6AZflGbbkaii20ORA+qbQtzXETKRYvE/f98Ep1/WuQ=;
        b=RblLcfDm+W2p/QjLVNy4nqu7KzNTsa3MF4OItGnQAKeLfhhc3MjERI/0TMFy7zO07k
         JXHneYRV30g9TtAWXlQNZCbwoTf/TcORskD6EQoMe46xYbDWk/JBEx3W8AYxZldIx462
         UdrKUoO0hUdVbVPm3iCwefcb8F+y7X7f5DNlgkLPbhWCI/dJXkW6lVNOMuo+cFyDaFtq
         oxBmvSyxw/F1CWUExl29FppiBx1IYQfIJ3Lo2vw96Vyxu7xNqD1co82+b79xSWYQE3tc
         EU5aLger/vjP89tpHUjHmzlEOF10EBnZ6l5aq7tx59zlio8chb8SD53XSq9oiz0iCPQE
         ZNuw==
X-Received: by 10.182.153.41 with SMTP id vd9mr787211obb.89.1370653379674;
 Fri, 07 Jun 2013 18:02:59 -0700 (PDT)
Received: by 10.60.120.103 with HTTP; Fri, 7 Jun 2013 18:02:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226776>

Hey Git Experts,

I need your advice. I have lot of png/jpg images in my codebase (which
is currently under git) which causes the repo size to be very heavy.
We have migrated these images to a storage server using git exile
technique. This has been working fine so far (with some glitches) on
unix platform. However to make it work on windows has been a big pain.
I got it work to some extent that I can pull stuff from storage and
replace the references here but its not complete. Also it made the
other commands like git status to be very slow. Does anybody have done
this before? If so can you please share your experience on it?



I tried using Cygwin but my Cygwin installation on windows 7 is not
going fine. Having failure in running the post install rebase script.
I am unable to checkout a package in Cygwin and I suspect it is
because of the post install stuff failure.

Any help/hints will be greatly appreciated.

--
Thanks & Regards
Sudhir Kumar
