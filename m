From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/4] submodules: Use relative paths to gitdir and work
 tree
Date: Wed, 07 Mar 2012 21:40:46 +0100
Message-ID: <4F57C7CE.1050005@kdbg.org>
References: <4F53DA95.2020402@web.de> <7v8vjcq5v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5NfX-00076u-CW
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 21:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759612Ab2CGUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 15:40:51 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:13231 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759609Ab2CGUku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 15:40:50 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8706CA7EB5;
	Wed,  7 Mar 2012 21:41:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7B0F219F604;
	Wed,  7 Mar 2012 21:40:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <7v8vjcq5v3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192480>

Am 07.03.2012 07:31, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> This is the third round of the former two patch series. It applies
>> cleanly on current master and maint and IMO is maint stuff as it fixes
>> bugs related to submodules. Those were introduced when moving the git
>> directory into that of the superproject and using a gitfile instead.
> 
> I looked at this again and think this addresses the review comments
> made during the previous round, but I would like to get "Yay" from
> people who helped reviewing the previous round.

Yay. The topic passes the test suite.

-- Hannes
