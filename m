From: Zach <zach@letmesearchthat.com>
Subject: Alphabetize git config --list
Date: Mon, 28 May 2012 13:58:28 -0700
Message-ID: <CAFus=5=cp62hpLM_Odog--Q0vER8kkT5Doqo28i-yZQyfvv4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 23:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ79B-0003mS-NA
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab2E1VGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 17:06:34 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:45055 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab2E1VGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 17:06:33 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2012 17:06:33 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp56.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 9F6A43D8C87
	for <git@vger.kernel.org>; Mon, 28 May 2012 16:58:29 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp56.relay.iad1a.emailsrvr.com (Authenticated sender: zach-AT-letmesearchthat.com) with ESMTPSA id 77F0A3D8C8C
	for <git@vger.kernel.org>; Mon, 28 May 2012 16:58:29 -0400 (EDT)
Received: by yenm10 with SMTP id m10so1604608yen.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 13:58:29 -0700 (PDT)
Received: by 10.42.12.83 with SMTP id x19mr3307350icx.16.1338238708725; Mon,
 28 May 2012 13:58:28 -0700 (PDT)
Received: by 10.231.66.6 with HTTP; Mon, 28 May 2012 13:58:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198723>

I was wondering if it would be possible to alphabetically order git
config --list by default.

Essentially this
$ git config --list | sort
