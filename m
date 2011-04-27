From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: preserve-merges fails on
 merges created with no-ff
Date: Tue, 26 Apr 2011 22:24:19 -0400
Message-ID: <4DB77E53.7070206@sohovfx.com>
References: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEuQZ-0006JV-SS
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab1D0CY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:24:26 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:53059 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755458Ab1D0CY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:24:26 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.9,
	required 6, autolearn=not spam, ALL_TRUSTED -1.00, BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QEuQS-0007cR-14
Received: from [99.231.190.188] (helo=ZanarkandMac.local)
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QEuQS-0007cR-14; Tue, 26 Apr 2011 22:24:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172158>

Could someone please take a look at this patch?
