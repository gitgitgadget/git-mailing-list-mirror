From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [RFC] git-gui window layout
Date: Fri, 12 Oct 2007 12:56:10 +0200
Message-ID: <470F52CA.3090308@users.sourceforge.net>
References: <470F3516.7020606@users.sourceforge.net> <470F45D6.6050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIKy-0003CR-Ji
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXJLLFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbXJLLFX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:05:23 -0400
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:53933 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXJLLFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:05:21 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id l9CB05e6029135;
	Fri, 12 Oct 2007 13:02:45 +0200 (CEST)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.67] (pc1067.et.put.poznan.pl [150.254.11.67])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l9CAu1S25821;
	Fri, 12 Oct 2007 12:56:01 +0200 (MET DST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070917)
In-Reply-To: <470F45D6.6050106@viscovery.net>
X-Enigmail-Version: 0.95.3
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2007.10.12.31041
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_24 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60673>

* Johannes Sixt [2007-10-12 12:00]:
> Adam Piatyszek schrieb:
>> I would like you to comment on my idea to change, or at least add a
>> possibility to change, the current layout of git-gui window.
>> [...]
>>
>> +-------------+----------------------------+---+
>> |             |                            |###|
>> |             |       commit log           |###|
>> |   staged    +----------------------------+---+
>> |             |                                |
>> |             |                                |
>> +----- 1 -----+                                |
>> |             |       diff output              |
>> |             2                                |
>> |  unstaged   |                                |
>> |             |                                |
>> |             |                                |
>> +-------------+--------------------------------+
> 
> May I point you to
> http://repo.or.cz/w/git-gui.git?a=commitdiff;h=a0592d3f5746b41c60fee71dd8d2d27b5c813907
> 
> which was committed 5 hours ago.
> 
> Except that it has Unstaged above Staged and Diff above Commit, which
> IMHO is much more natural.

Thanks for the info! It seems that I was a bit late with my proposal. ;-)

/Adam


-- 
.:.  Adam Piatyszek - "ediap"       .:.  JID: ediap(at)jabber.org .:.
.:.  ediap(at)users.sourceforge.net .:.  PGP key ID: 0x1F115CCB   .:.
