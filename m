From: "A.S. Bradbury" <asbradbury@tekcentral.org>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 13:38:55 +0100
Message-ID: <e4881a300705070538w4187450bo5c7d5aed4a2bbc12@mail.gmail.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
	 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
	 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
	 <463ECEF4.625F3633@eudaptics.com>
	 <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
	 <463F14FF.F8DF11EB@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 14:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2UX-0006CO-0j
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbXEGMi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 08:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933571AbXEGMi6
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:38:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:19527 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbXEGMi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:38:57 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1562701wra
        for <git@vger.kernel.org>; Mon, 07 May 2007 05:38:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=n0ADudkXzLRbYAeBDLH9OtK56VYG66ZUFzPI7FXSb+iBa2nLPAmgKbznGhztzoQUAl57w2ciPSGD5mD7sgC+UdqURaEJPkljcSlQuYq/1h5MLL47rY03NXUApUlLsXcaUwuolNQPQJLWVJ2ur96KGaAvf+tS3qR3A2EhlIEsXRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GHI104l3h7mt3p4ineg1w9UvaNKLOXGMqZCLlfYplbKDM/cDifC+yK5/oQZ/0ET7V7sd61XZMwtLfqAJb2PqsxmBYyt28LRKt00yE/+aWgHtq0xSf7aanc5A8hVnQEIhRQm7UUPvwdNxHGXCt/s45d1wt2uaznrrhJ785n2vhuU=
Received: by 10.114.171.1 with SMTP id t1mr1692569wae.1178541535267;
        Mon, 07 May 2007 05:38:55 -0700 (PDT)
Received: by 10.114.77.11 with HTTP; Mon, 7 May 2007 05:38:55 -0700 (PDT)
In-Reply-To: <463F14FF.F8DF11EB@eudaptics.com>
Content-Disposition: inline
X-Google-Sender-Auth: c19ffb3abfcf3a25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46456>

On 5/7/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> The next big thing to think about is an installer. Does anyone have a
> suggestion for a free installer tool? I only know about Microsoft's WiX
> (wix.sf.net), but it requires .NET (for the developer, not the user).

This is outside my normal realm of expertise, but I think NSIS
(http://nsis.sourceforge.net) is where it's at - notable users include
Firefox 2.0, OOo, VLC etc etc...

Alex
