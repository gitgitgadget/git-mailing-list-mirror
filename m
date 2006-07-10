From: "Peter Gervai" <grin@grin.hu>
Subject: newbie'ish FAQ/question about merging different trees
Date: Mon, 10 Jul 2006 13:56:56 +0200
Message-ID: <d55656c10607100456o761bb342p3db229b499579dd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 13:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzuNu-0004dD-WA
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 13:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWGJL47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGJL47
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 07:56:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:29916 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751339AbWGJL46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 07:56:58 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3845118ugf
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 04:56:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=h+t7nzxj/CIXRluvISwW7ly3iL8c2J2My0iZMx0t6f3wchq0YZN/h4Nsc3m8fXKIUpzKYIUTER2TEGTxDr3QCjaZF/13KxuW28IbgiBVzaG4jT6o6n4vHAPHh9DCIz27Xxl0Fu2FRfcQjjfLGyyU8m/uOyvcsx9ETo/md43b7+I=
Received: by 10.78.177.11 with SMTP id z11mr1616384hue;
        Mon, 10 Jul 2006 04:56:57 -0700 (PDT)
Received: by 10.78.53.1 with HTTP; Mon, 10 Jul 2006 04:56:56 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Google-Sender-Auth: 4a59337a8c6aea84
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23612>

Hello,

I ask with specifics to make it easier to get, but the question
probably general.

In one sentence: I would like to use
linux/kernel/git/jejb/aic94xx-sas-2.6.git with the current released
kernel, which is 2.6.17.4 at the moment.


In more sentences:
There are two trees on kernel.org's git:

linux/kernel/git/jejb/aic94xx-sas-2.6.git  (it seems to be at 2.6.16-rc5)
linux/kernel/git/torvalds/linux-2.6.git (it probably does have a tag
at v2.6.17.4)

Is there a way to merge these to produce 2.6.17.4 (latest released), patched?

Thanks,
Peter

ps: ...apart from asking the subtree's maintainer to update his tree...
