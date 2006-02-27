From: Aubrey <aubreylee@gmail.com>
Subject: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 22:57:05 +0800
Message-ID: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 15:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDjoF-0007tp-VH
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 15:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWB0O5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 09:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWB0O5H
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 09:57:07 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:39261 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWB0O5G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 09:57:06 -0500
Received: by pproxy.gmail.com with SMTP id i75so744614pye
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 06:57:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j4eRAfwlygF0k+IZR/WIi2Mdio75DopMm0qWf1O0XIS0OGBzJbl9HiaWbzRdZFi1jUI9UcMZKvHVCpKs5gKjIc3zIjTxjdAwfGz7t0ZVZHvB/OkogQ8XyGgB4+nNH/jw6e6GUK5CCt2DN29gAGCnLIBBqEhIL4tfgrXA1Xcot94=
Received: by 10.65.225.13 with SMTP id c13mr4392840qbr;
        Mon, 27 Feb 2006 06:57:05 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 06:57:05 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16850>

Hi all,

I'm a newbie of git. I have a question about how to generate a patch by git.
I want to make a patch againt git repository HEAD. So in my local
tree, I do the command:

git diff -p > my.patch

The file my.patch is generated. But the unchanged files information is
also included in the patch file. It should be quiet.
Was I wrong to use git by this way?

Thanks for your hints.

Regards,
-Aubrey
