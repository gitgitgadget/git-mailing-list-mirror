From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [PATCH] git svn dcommit: avoid self-referential
 mergeinfo lines when svn.pushmergeinfo is configured
Date: Thu, 15 Mar 2012 15:28:56 -0700
Message-ID: <4F626D28.70100@vilain.net>
References: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com> <20120315220242.GA9348@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avishay Lavie <avishay.lavie@gmail.com>, git@vger.kernel.org,
	Bryan Jacobs <bjacobs@woti.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:29:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8JAQ-0005D1-KH
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031108Ab2COW3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:29:01 -0400
Received: from uk.vilain.net ([92.48.122.123]:44564 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964997Ab2COW3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:29:00 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 215158279; Thu, 15 Mar 2012 22:28:59 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 2074A8165;
	Thu, 15 Mar 2012 22:28:56 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120315220242.GA9348@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193234>

On 3/15/12 3:02 PM, Eric Wong wrote:
> Avishay Lavie<avishay.lavie@gmail.com>  wrote:
>> [PATCH] git svn dcommit: avoid self-referential mergeinfo lines when
>> svn.pushmergeinfo flag is configured
>
> Subject line is too long, ~50 chars is the limit.
> See git-commit(1) / Documentation/SubmittingPatches

Can I suggest:

git svn dcommit: avoid self-referential mergeinfo
