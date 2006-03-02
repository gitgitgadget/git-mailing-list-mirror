From: Aubrey <aubreylee@gmail.com>
Subject: Re: git push issue
Date: Thu, 2 Mar 2006 18:46:58 +0800
Message-ID: <6d6a94c50603020246g1520ceahb970da7bbf965dfc@mail.gmail.com>
References: <6d6a94c50603020147l450d1cdfp1bc1747dc79189ce@mail.gmail.com>
	 <7v4q2h6ucs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 11:47:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FElL1-0005Hi-50
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 11:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWCBKrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 05:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWCBKrA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 05:47:00 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:51835 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751983AbWCBKq7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 05:46:59 -0500
Received: by wproxy.gmail.com with SMTP id i3so621595wra
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 02:46:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oyzvdK/uQpzaMEFrfVmma2wwCHGKz/Q2xWGbU6jDJrXKMtBxm4JcdQYHdDjAQ/uL0oTm8t1X/9uGIbsu7Zzsn8AXNNSgzuSGq9xX2NpsWxC370GrzxqzpyUd6EtjHAglLQrMMJCEtsH1ERLjXCB9z2SbeEHdhRy8rpf9IIEpKXo=
Received: by 10.65.147.15 with SMTP id z15mr580064qbn;
        Thu, 02 Mar 2006 02:46:58 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Thu, 2 Mar 2006 02:46:58 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v4q2h6ucs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17062>

Thanks a lot.
Now git push is OK.
Is it time to try to clone the git repository from the remote machine to my end?
I have started up the git-daemon, but still get the following error:
============================================================
 git clone git://10.99.22.20:/home/aubrey/public_html/my-git.git git-test
fatal: unable to connect a socket (Connection refused)
clone-pack from 'git://10.99.22.20:/home/aubrey/public_html/my-git.git' failed.

If I want to clone it by http:// or git://, Could you please give me
some instructions or docs?

Thanks a million.

Regards,
-Aubrey
