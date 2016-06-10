From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: What's cooking in git.git (Jun 2016, #03; Thu, 9)
Date: Fri, 10 Jun 2016 12:24:41 +0200
Message-ID: <7c9b1781-02b2-adb3-dd90-d5b2cc9017f1@virtuell-zuhause.de>
References: <xmqqbn3ai8g8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:25:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBJcg-0005FD-SI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 12:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbcFJKYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 06:24:52 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46988 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbcFJKYu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 06:24:50 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1bBJcO-0000Aw-KR; Fri, 10 Jun 2016 12:24:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqqbn3ai8g8.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465554290;b17adc4a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296965>

Am 09.06.2016 um 19:21 schrieb Junio C Hamano:
> * tb/complete-status (2016-06-06) 3 commits
>  - completion: add git status
>  - completion: add __git_get_option_value helper
>  - completion: factor out untracked file modes into a variable
> 
>  The completion script (in contrib/) learned to complete "git
>  status" options.
> 
>  Breaks t9902.

Fixed in v5.
