From: Luis Ressel <aranea@aixah.de>
Subject: [GSoC microproject] Add XDG support to the credential-store helper
Date: Thu, 5 Mar 2015 21:51:46 +0100
Message-ID: <20150305215146.394caa71@gentp.lnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 22:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTd1U-0008RF-7m
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 22:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbbCEVJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 16:09:32 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:40774 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693AbbCEVJb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 16:09:31 -0500
X-Greylist: delayed 1061 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2015 16:09:30 EST
Received: from hsi-kbw-046-005-229-078.hsi8.kabel-badenwuerttemberg.de ([46.5.229.78] helo=gentp.lnet); authenticated
	by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YTckF-0000Mb-Ji; Thu, 05 Mar 2015 21:51:47 +0100
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
	by gentp.lnet (Postfix) with ESMTP id D0A0F260166;
	Thu,  5 Mar 2015 21:51:46 +0100 (CET)
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1425589771;338c6d39;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264868>

I'm contributing this patch in preparation for a GSoC15 application with
the git project. In particular, I'm interested in the two bisect
improvements listed on the Ideas page. Does anyone have other
suggestions for potential improvements of git bisect that would be
suitable for such a GSoC project?

Oh, and should I add a testcase for the new functionality introduced by
this patch? And if yes, what exactly should I test?

Also, apologies if these mails arrive twice. I'm resending them because
Majordomo seems to have ignored my initial attempt 6 hours ago.

Regards,
Luis Ressel
