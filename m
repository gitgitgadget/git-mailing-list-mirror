From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Remove git-findtags.perl
Date: Wed, 2 Nov 2005 10:15:01 +1300
Message-ID: <46a038f90511011315s9d80730obba422f5a44360d7@mail.gmail.com>
References: <20051101202603.16900.9063.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 22:16:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX3TP-0004VY-CD
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 22:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVKAVPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVKAVPF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 16:15:05 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:18357 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751257AbVKAVPC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 16:15:02 -0500
Received: by xproxy.gmail.com with SMTP id i30so1442559wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 13:15:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C5hPN5loI8LRlhP8ChOwVzZvcqi0K9IM0sw3oIhP0KUUQwp264awrKFrw+6zOqgcDjQLyEKab2eMJW5tjdZYfM3F+VILh6oqDzFWfpn1tS77r43zmKm7if7FpYefYWbHG/aqASQzC9BG29/5ck1/BfFrdIh0VKILu2OpA5GcwRE=
Received: by 10.65.192.11 with SMTP id u11mr1393926qbp;
        Tue, 01 Nov 2005 13:15:01 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Tue, 1 Nov 2005 13:15:01 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051101202603.16900.9063.stgit@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10955>

On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> This script was superseded by git-name-rev, which is more versatile,
> actually documented, faster, and everything else...

Definitely! I hadn't registered the addition of git-name-rev, but it
seems to be a much better solution.

cheers!


martin
