From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: How do I quickly check what heads a particular commit is in?
Date: Mon, 24 Apr 2006 16:23:24 +1200
Message-ID: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 24 06:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXsbg-00066H-K3
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 06:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWDXEX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWDXEXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 00:23:25 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:61307 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751503AbWDXEXZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 00:23:25 -0400
Received: by wproxy.gmail.com with SMTP id i7so992266wra
        for <git@vger.kernel.org>; Sun, 23 Apr 2006 21:23:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qoc+GzqcD9UOmkzatV6AlUuVIIaHXxDB8EBt33U8vyvvKb7iwcf9g9mpVl73dpghq2/5+wQME6Xz/0eQDN8bma8+x0/wVoVBFnvZTalQoNAiA3YwclF/78VDtm65sf6OYr3101nnt7XoQwWZov88vS5dcAU3cvf0u9MRjgfwX08=
Received: by 10.54.106.17 with SMTP id e17mr4270549wrc;
        Sun, 23 Apr 2006 21:23:24 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Sun, 23 Apr 2006 21:23:24 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19085>

In the middle of a merge of 2 of a bunch of closely related heads, I
found a few odd things, so I've pickaxe'd and found the (potentially
bogus) commits. I am using gitk, and while I do find the commit, it's
not very clear what heads have the dodgy commit. They've probably been
for a few months in there <sigh>.

Is there a practical way to ask in what heads they are?



martin
