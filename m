From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: This seems somewhat less that ideal
Date: Mon, 30 Apr 2007 18:20:19 -0400
Message-ID: <46366BA3.3040205@gmail.com>
References: <4634F508.5020702@gmail.com> <Pine.LNX.4.64.0704302146470.29859@racer.site>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 01 00:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HieEg-0006HG-5G
	for gcvg-git@gmane.org; Tue, 01 May 2007 00:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423381AbXD3WUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423747AbXD3WUn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 18:20:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:19687 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423381AbXD3WUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 18:20:24 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1679852wxd
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 15:20:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FgmCAiWstG+1tyGqKpMBfKMTfQX/SeBb9UskFyL2Nh+4Lj0IQ7ndWWshUqHmskc+4ogbs7lF1krL8TC3N97newAFgRsiTYfIwskSPFFU+ZW91B/01KsjkeX4cK8JPX1YYhQyGR1rEK9782S1ukgqXz2Q6JOQHLciefyJ7fLoSXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o9nLvMjjTTX5HL2XiWr99Y9Aryc8egaiw4NI+kdqNafHvRpATZfna4Tj6HQT5pr0mLVXQ2rA7i08CHc2rB8vyoJ+f4CNTAGwvEmewiAJkNfz4u/CfZab3Yv0cp6y54c7EXZnH5roSMZmILzNggHqDy+MbSqw02K7Tya63eehONo=
Received: by 10.70.31.14 with SMTP id e14mr12096459wxe.1177971622724;
        Mon, 30 Apr 2007 15:20:22 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h14sm3317141wxd.2007.04.30.15.20.20;
        Mon, 30 Apr 2007 15:20:20 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <Pine.LNX.4.64.0704302146470.29859@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45883>

Johannes Schindelin wrote:
> On Sun, 29 Apr 2007, A Large Angry SCM wrote:
> 
>> The latest pull (fetch) transfered almost the entire history. Yet, I was
>> up-to-date as of last night.
>>
>>
>> remote: Generating pack...
>> remote: Done counting 46473 objects.
>> remote: Deltifying 46473 objects.
>> remote:  100% (46473/46473) done
> 
> Hmmm. This hasn't happened in a real long time for me. Do you have an old 
> client?

It was built from the previous master, 4342572. Very odd.
