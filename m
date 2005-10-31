From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 14:59:41 +1300
Message-ID: <46a038f90510301759p26fa4b0wd67025f069c2373a@mail.gmail.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 03:00:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWOxm-0006hK-Ss
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 02:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJaB7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 20:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJaB7o
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 20:59:44 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:26766 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751153AbVJaB7o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 20:59:44 -0500
Received: by wproxy.gmail.com with SMTP id i28so421703wra
        for <git@vger.kernel.org>; Sun, 30 Oct 2005 17:59:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9nMXKVSYuqr7ZWnagMfMcrxa2HRwZpx4dS4vQ1/M4gTm53cRW+Vxr6g7JirMzcxVzCIc9nKntpaB8tXSKD/CU5j0q942GclSnwM1pv5x0UOn0gOSdGYfpcerEDB4bVXLzfBp++ZEpOtGxit1fW6l3To92e0NMIQJKvXKoqIUhA=
Received: by 10.64.143.6 with SMTP id q6mr1149279qbd;
        Sun, 30 Oct 2005 17:59:41 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Sun, 30 Oct 2005 17:59:41 -0800 (PST)
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10845>

On 10/31/05, walt <wa1ter@myrealbox.com> wrote:
> Could someone explain to me the shortcomings of CVS which prompted
> the development of bk (and then git) -- in a way that a non-developer
> like me can understand?

You need to understand the SCM "problem space" at least a little bit.
Can't cheat on that unfortunately.

The writeup at http://www.dwheeler.com/essays/scm.html is not perfect,
but should give you a bit of background. It barely covers git -- we
need to prod the author to update it ;)



martin
