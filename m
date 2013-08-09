From: Dmitry Kuzminov <dkuzminov@yandex-team.ru>
Subject: Git for the Windows 1.8.3, GIT Bash icon issue
Date: Fri, 09 Aug 2013 21:00:51 +0400
Message-ID: <40631376067651@webcorp2d.yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 19:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7q9i-00014O-Lk
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab3HIRHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:07:08 -0400
Received: from forward5.mail.yandex.net ([77.88.46.21]:42550 "EHLO
	forward5.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab3HIRHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:07:07 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2013 13:07:07 EDT
Received: from webcorp2d.yandex-team.ru (webcorp2d.yandex-team.ru [77.88.47.170])
	by forward5.mail.yandex.net (Yandex) with ESMTP id 103761200907
	for <git@vger.kernel.org>; Fri,  9 Aug 2013 21:00:52 +0400 (MSK)
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by webcorp2d.yandex-team.ru (Yandex) with ESMTP id E9A98FFCF;
	Fri,  9 Aug 2013 21:00:51 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1376067651;
	bh=AOhLThPFqfbnCpKxRW20mgCr7Hw1IXMq9H7UfTjydRc=;
	h=From:To:Subject:Date;
	b=EL1zZeMOpi+lPSP4O2JSTiV9hGvyNJIjTgJKQujjN4iQJMX21bSS8z+AIbIapM18Q
	 ncJZqyNZS/W1Z7m1rz3z5a9Tb/Ns+0rDtldxZ7LNDkmbRBxl8vHR+a6yrUMqte0bxO
	 lpQLVT3E/HgTBTcnF9AL39RaeZ4jTzv1Og3KnZ+E=
Received: from dhcp-3-237-ben.yandex.net (dhcp-3-237-ben.yandex.net [77.88.3.237]) by webcorp2d.yandex-team.ru with HTTP;
	Fri, 09 Aug 2013 21:00:51 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231996>

There is a standard command prompt icon in taskbar for GIT Bash instead of GIT icon

Steps to reproduce:
Select Taskbar Properties, Taskbar buttons, set to "Never combine"
Run GIT Bash

Best regards,
Dmitry Kuzminov
