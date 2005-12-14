From: Don Zickus <dzickus@gmail.com>
Subject: Re: StGIT usage
Date: Wed, 14 Dec 2005 12:02:13 -0500
Message-ID: <68948ca0512140902t6b44b2c1icb5dc1435b94ddb@mail.gmail.com>
References: <68948ca0512140844u677fea36ob94bdf213a6a110@mail.gmail.com>
	 <20051214165304.GA9272@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 14 18:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ema1Q-0000ko-1T
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 18:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVLNRCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 12:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLNRCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 12:02:16 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:44420 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964877AbVLNRCO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 12:02:14 -0500
Received: by wproxy.gmail.com with SMTP id i27so140474wra
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 09:02:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CsmIilwwNAcxfv8GpMQ3wbe8LDLXVfL/TLYyGVtOm5133P/RjuGC/C4u/Xsh3LIPUmITziWBA5X8Ry/6kbJV8niub1QY2Jq1PpfLBkav13Iwd+8DmMrIupSnp2U56S1C4VC3jCpUwrthzipWqch5PLZykXrb+++Xzbdi21xv02g=
Received: by 10.65.133.2 with SMTP id k2mr573985qbn;
        Wed, 14 Dec 2005 09:02:13 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Wed, 14 Dec 2005 09:02:13 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20051214165304.GA9272@ferdyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13635>

> If import will do once at a time, and you are sure all of them apply
> cleanly; why don't you just use a for + import over the patches ?
>

Patch ordering is important to me. I didn't want re-invent the wheel,
so to speak.   :)

I can easily create my own 'series' file and iterate through that
while importing patches, but I wanted to see if that was already
built-in.

Cheers,
Don
