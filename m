From: Laszlo Papp <djszapi@archlinux.us>
Subject: TortoiseGIT
Date: Tue, 15 Dec 2009 16:41:04 +0100
Message-ID: <a362e8010912150741x2c39c01bh1f64e669726dafab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 16:41:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKZWV-0008R1-7g
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 16:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZLOPlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 10:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZLOPlJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 10:41:09 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39090 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZLOPlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 10:41:07 -0500
Received: by yxe17 with SMTP id 17so3740306yxe.33
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 07:41:04 -0800 (PST)
Received: by 10.101.132.11 with SMTP id j11mr8037557ann.142.1260891664428; 
	Tue, 15 Dec 2009 07:41:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135286>

Hello,

I had got a problem in the past with cr + lf between windows and linux
client(maybe now too).
I heard that from more experienced users I need to set autocrlf +
safecrlf on windows, and core.autocrlf false on linux (which is the
default), but If I set core.autocrlf true on linux too, it worked
normally, after a git pull on windows I don't see any modified file
that should be committed, not the case in core.autocrlf false.

Could someone explain this habbit of git, please ?

Everybody said I need to set autocrlf for false, but it doesn't work
so, just with true on linux client, what do I do wrong ?
It's okay now for me, because it works without any problem, I just
don't understand the behaviour of it, and I don't know whether it will
cause further problems.

Thanks in advance!

Best Regards,
Laszlo Papp
