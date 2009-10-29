From: Laszlo Papp <djszapi@archlinux.us>
Subject: Insertions/Deletions summary for a contributor
Date: Thu, 29 Oct 2009 07:44:40 +0100
Message-ID: <a362e8010910282344vad53b7ck1b7ae04ff3c499ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 07:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OkX-0004Ay-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbZJ2Gog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbZJ2Gog
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:44:36 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33815 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZJ2Gof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:44:35 -0400
Received: by yxe17 with SMTP id 17so1417892yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:44:40 -0700 (PDT)
Received: by 10.100.24.37 with SMTP id 37mr777106anx.45.1256798680703; Wed, 28 
	Oct 2009 23:44:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131561>

Hello,

It would be nice to see summary for a contributor in insertions/deletions
lines, changed files regard, in the life of the whole project.

So the output would be the summary of the following output lines:
git log --author="Laszlo Papp" --pretty=tformat: --numstat

Can I deal with it, does it make sense, what do you think about it ?

Best Regards,
Laszlo Papp
