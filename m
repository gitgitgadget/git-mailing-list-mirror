From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [ANNOUNCE] Git v2.1.0
Date: Sun, 17 Aug 2014 15:10:37 +0100
Message-ID: <53F0B7DD.7000605@ramsay1.demon.co.uk>
References: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Aug 17 16:11:13 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XJ1At-00086K-VB
	for glk-linux-kernel-3@plane.gmane.org; Sun, 17 Aug 2014 16:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaHQOKp (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 17 Aug 2014 10:10:45 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:34767 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751494AbaHQOKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2014 10:10:43 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 63D8CAC40BF;
	Sun, 17 Aug 2014 15:10:39 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 329A0AC40BE;
	Sun, 17 Aug 2014 15:10:39 +0100 (BST)
Received: from [192.168.254.2] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Sun, 17 Aug 2014 15:10:38 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 17
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255368>

On 15/08/14 23:46, Junio C Hamano wrote:
> The latest feature release Git v2.1.0 is now available at the
> usual places.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/
> 
> The following public repositories all have a copy of the 'v2.1.0'
> tag and the 'master' branch that the tag points at:
> 
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = https://code.google.com/p/git-core/
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
> 

Are you going to tag and push v2.1.0 to the documentation repos?
(I have been watching the kernel.org documentation repos - should
I be looking elsewhere?)

I stopped building the documentation myself when my documentation
toolchain got a bit old. I have upgraded to Linux Mint 17 since
then, so my toolchain may be up to the job now, so perhaps I should
build it myself. ;-)

ATB,
Ramsay Jones
