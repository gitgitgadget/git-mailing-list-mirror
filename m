From: Eric Herman <eric@freesa.org>
Subject: Re: [PATCH v2 0/3] grep multithreading and scaling
Date: Fri, 02 Dec 2011 21:02:44 +0100
Message-ID: <4ED92EE4.7030404@freesa.org>
References: <201111291507.04754.trast@student.ethz.ch> <cover.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 02 21:03:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWZK6-0004AL-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 21:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1LBUCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 15:02:49 -0500
Received: from dsl017-020-053.chi1.dsl.speakeasy.net ([69.17.20.53]:55350 "EHLO
	chirm.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754402Ab1LBUCt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 15:02:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by chirm.localdomain (Postfix) with ESMTP id CC5F0217B99;
	Fri,  2 Dec 2011 15:10:23 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <cover.1322830368.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186238>

Hello Thomas,

Thanks for the work and the great info.
Some of the numbers are quite surprising.

I do, indeed, have a machine with more cores, but I have been either 
busy with out-of-town guests or generally plain lazy in the last couple 
of weeks. I intend to set aside some time to do some benchmarking this 
weekend.

I'll let you know what I find.

Cheers,
  -Eric



-- 
http://www.freesa.org/ -- mobile: +31 620719662
aim: ericigps -- skype: eric_herman -- jabber: eric.herman@gmail.com
