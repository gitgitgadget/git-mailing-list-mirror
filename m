From: Aubrey <aubreylee@gmail.com>
Subject: Re: git push issue
Date: Thu, 2 Mar 2006 23:21:41 +0800
Message-ID: <6d6a94c50603020721t75a8e298q99712bbae41abe16@mail.gmail.com>
References: <6d6a94c50603020147l450d1cdfp1bc1747dc79189ce@mail.gmail.com>
	 <7v4q2h6ucs.fsf@assigned-by-dhcp.cox.net>
	 <6d6a94c50603020246g1520ceahb970da7bbf965dfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 16:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpcg-0001Ct-BT
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWCBPVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCBPVn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:21:43 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:21954 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751468AbWCBPVm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:21:42 -0500
Received: by zproxy.gmail.com with SMTP id i11so452252nzi
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 07:21:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L3rOSCykgocnsZYfwARtS6aBVuEzht7HOSAiIWMEvHsfLwSXtI3RLI3RoAe/qoRJUq8MS58nISFWS6cNaqm0TPl2MVLIuMgMRaJ0pdpuOCpKbR+rLrLrwSpsl4ZZYuzmxFFeHJz6toBOPfs4P3dfZd8X6fe1O9nMZ4aSVPq6yrw=
Received: by 10.65.121.11 with SMTP id y11mr734031qbm;
        Thu, 02 Mar 2006 07:21:41 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Thu, 2 Mar 2006 07:21:41 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <6d6a94c50603020246g1520ceahb970da7bbf965dfc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17077>

OK. I help myself out.
It's not complex to put own work on a web server. And it works on my
end. Because git:// or rsync:// need the port which it's possibly
unaccessible behind a firewall. I think it's good enough so far to use
http connection.

Regards,
-Aubrey
