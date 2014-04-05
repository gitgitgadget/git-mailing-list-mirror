From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Sat, 05 Apr 2014 11:19:14 +0200
Message-ID: <533FCA92.8060006@kdbg.org>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Stefan Zager <szager@chromium.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 11:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWMlU-0004Rr-Uu
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 11:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbaDEJTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 05:19:20 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:7240 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754144AbaDEJTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 05:19:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3A66D13004D;
	Sat,  5 Apr 2014 11:19:16 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 790AE19F3E8;
	Sat,  5 Apr 2014 11:19:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245779>

Am 04.04.2014 22:58, schrieb Junio C Hamano:
> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>  - Enable index-pack threading in msysgit.
> 
>  What is the status of this topic?  A failure report exists
>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>  where the discussion stalled.  Is everybody waiting for everybody
>  else to get the discussion unstuck?

I still have to cross-check Duy's patch. I'll hopefully get to it in the
next days and report back.

-- Hannes
