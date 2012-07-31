From: Jialin Liu <jialinliu7@gmail.com>
Subject: a error in git documentation
Date: Mon, 30 Jul 2012 22:38:50 -0400
Message-ID: <DBDC25FF-7978-49BF-AB39-5EF9496F5456@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 04:38:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw2MJ-0000Q6-7q
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 04:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab2GaCiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 22:38:50 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63346 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab2GaCit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 22:38:49 -0400
Received: by gglu4 with SMTP id u4so5599171ggl.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer;
        bh=SY0FjRBxWZHNzT9SQcitWXWUV9ssfKrQ1EQt29DyJ+E=;
        b=zBrtWQlPqnvRGpCi8BRWYh5rAlHtZ9+ozEPlns4ZSbJ7WPmM9ceXiMc4EwSMJ2rz8k
         +vfK/AIVrPQxNVsZaHNCiXAcXLjpiy9tv6YY4Z3ZfaGZH3x0lxMyck4u4ed9WKqHTF4T
         4OjWPUN9xr/NGpF33c8opAJQLHaSTWru4q2sWGKFPpixHIkaAxa6gN+Y2mAJkq7p8xeP
         /1+CrONt0YhEicAbRZ31WD1hudF6fwDl/LPJM8LcbBog/sYqd3vgVKFGBNVfryHaNTcO
         uk8oaF7uOhSOgLcbLLzDIHSQOvTydKo+Y68LM/C6wuM2maFbENZ96hXN9vE9kQqUCPvA
         DPgg==
Received: by 10.50.213.98 with SMTP id nr2mr574907igc.71.1343702328392;
        Mon, 30 Jul 2012 19:38:48 -0700 (PDT)
Received: from [192.168.1.103] (cpe-184-58-119-100.woh.res.rr.com. [184.58.119.100])
        by mx.google.com with ESMTPS id ch4sm8128601igb.2.2012.07.30.19.38.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 19:38:47 -0700 (PDT)
X-Mailer: Apple Mail (2.1485)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202625>

In http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repos=
itory

Notice how you don=92t have to run git add on the benchmarks.rb file in=
 this case before you commit.

I think how should be changed to now