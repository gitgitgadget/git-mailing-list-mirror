From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: minor consistency fixes in   git-difftool.txt.
Date: Wed, 25 Mar 2009 11:21:38 +0100
Message-ID: <49CA05B2.7020207@drmicha.warpmail.net>
References: <1237961655-29147-1-git-send-email-davvid@gmail.com> <7vocvq842a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 11:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQGV-0003Hp-0l
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 11:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbZCYKVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 06:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZCYKVs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 06:21:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43166 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752597AbZCYKVr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 06:21:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 28A8F2FC4FB;
	Wed, 25 Mar 2009 06:21:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Mar 2009 06:21:45 -0400
X-Sasl-enc: 8JgGCgQGiiJuRuwWQ73nhVHCPEYK2BLRf9LLZV0e4xir 1237976504
Received: from localhost.localdomain (p4FC63420.dip0.t-ipconnect.de [79.198.52.32])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53B0B53C60;
	Wed, 25 Mar 2009 06:21:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090324 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vocvq842a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114579>

Junio C Hamano venit, vidit, dixit 25.03.2009 08:17:
> David Aguilar <davvid@gmail.com> writes:
> 
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>>  Documentation/git-difftool.txt |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
>> index 5ae02f8..23070c1 100644
>> --- a/Documentation/git-difftool.txt
>> +++ b/Documentation/git-difftool.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  DESCRIPTION
>>  -----------
>>  'git-difftool' is a git command that allows you to compare and edit files
>> -between revisions using common diff tools.  'git difftool' is a frontend
>> +between revisions using common diff tools.  'git-difftool' is a frontend
> 
> I thought that the recent trend is to spell these as 'git difftool' (two
> separate words), although I didn't follow the discussion on quoting styles
> closely, so I do not know which of sq, dq or backtick is preferred.
> 
> Can somebody help me out here?
> 

I'd say it's backticks for commands/code, but I think discussion about a
style guide is still on.

Michael
