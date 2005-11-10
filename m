From: Tony Luck <tony.luck@intel.com>
Subject: Re: Where should I post questions on GIT usage ?
Date: Thu, 10 Nov 2005 10:27:39 -0800
Message-ID: <12c511ca0511101027q44c51ca8h88229fd7188717d5@mail.gmail.com>
References: <cda58cb80511100017v12f8ec77v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 19:28:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaH9E-0001sK-P9
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVKJS1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVKJS1m
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:27:42 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:25761 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932131AbVKJS1l convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 13:27:41 -0500
Received: by xproxy.gmail.com with SMTP id s14so672090wxc
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 10:27:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rg87tmw4T7THPHGQFSHnGYLfufEOTMJViI2Rd6uC2YgQWLX5uM/G7rzOg1FVZMgYFk1cEymzDeRtoQ62wJsWgllSvz63mBoZEEIO+OQ6CEmkyZ5OiNtWxt+JsktIrzhsxExLR1+nW7Oz2CH5D1FXDpKMJS+mhThDTFJDs3bJbVU=
Received: by 10.64.91.5 with SMTP id o5mr522005qbb;
        Thu, 10 Nov 2005 10:27:40 -0800 (PST)
Received: by 10.65.194.8 with HTTP; Thu, 10 Nov 2005 10:27:39 -0800 (PST)
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511100017v12f8ec77v@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11498>

> I'm starting using GIT, and I'm having a couple of basic questions to
> ask. Is it the correct place to post them or is there any other
> mailing list related to GIT usage ?

Read Documentattion/tutorial.txt (and any relevent Documentation/howto/* files).

Search the archives.

If you still have problems, then the best format for questions here seems
to be:

1) I was trying to do ... insert high level description here.

2) So I executed these git commands ...

3) And what happened was ...

Skipping step 1 can cause delays while people answer questions about
the specific micro-problems you had with the commands in step 2, when
the real answer is to use some totally different command.

-Tony (far more frequently an asker-of-questions than an answerer)
