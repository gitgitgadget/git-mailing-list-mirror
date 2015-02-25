From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [ANNOUNCE] Git v2.3.1
Date: Wed, 25 Feb 2015 15:07:09 -0500
Message-ID: <54EE2B6D.10403@avirtualhome.com>
References: <xmqqzj82o4n1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:27:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQiXf-00059w-52
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 21:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbbBYU0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 15:26:37 -0500
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:46259 "EHLO
	mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbBYU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 15:26:36 -0500
X-Greylist: delayed 1165 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Feb 2015 15:26:36 EST
Received: from [192.168.1.106] (c-69-248-90-230.hsd1.nj.comcast.net [69.248.90.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.avirtualhome.com (Postfix) with ESMTPSA id 6932D174CF;
	Wed, 25 Feb 2015 15:07:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.9.1 mail.avirtualhome.com 6932D174CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avirtualhome.com;
	s=mail; t=1424894830;
	bh=Xw1GtZnonlR5RQZLZsbZ1xpoNU3L+0hu6u8iUTrMhnQ=;
	h=Subject:To:references:From:Date:in-reply-to:From;
	b=mPFKLR25+/OzsXpX7q7pAPeUFVERgBySHs9EX7iMWtozywm44t6jqBtkbWSDAUIii
	 BTplDroEhg2mbEUcu9FZED0bRbO9gSCHqYLv1sIUYgQhO7poZlP+aN4QwacdjKy0pG
	 I8j8To3SFy8HryQEoOvHaCQ77Gl4Sz9rSONR6pfI=
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:37.0) Gecko/20100101 Thunderbird/37.0a2
in-reply-to: <xmqqzj82o4n1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264412>

On 02/25/2015 02:02 AM, Junio C Hamano wrote:
> The latest maintenance release Git v2.3.1 is now available at
> the usual places.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/
> 
> The following public repositories all have a copy of the 'v2.3.1'
> tag and the 'maint' branch that the tag points at:
> 
>   url = git://repo.or.cz/alt-git.git
>   url = https://code.google.com/p/git-core/
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
> 

The tag seems to be missing on Github.
