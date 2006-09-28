From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 13:46:12 -0700
Message-ID: <451C3494.8030701@gmail.com>
References: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 22:46:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT2lz-0006Sl-TR
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 22:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWI1UqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWI1UqU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 16:46:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:969 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWI1UqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 16:46:19 -0400
Received: by nf-out-0910.google.com with SMTP id o25so826484nfa
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 13:46:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kwqPNMXvl96wgpapFDTGhMggR62o/+YZrl2lXhJ2XatA2vDyFr87CgUemBZot4fkPZae70yNxbEv5c6uoGaid/Emg0/BsdgnpFIXmI6QDhHxlrOjQw1MlV8JadXghbbiEkzVHxVfNjiISvhA5pBsSpC3EYPnh6RPWXBSZ1vj33c=
Received: by 10.49.10.3 with SMTP id n3mr595088nfi;
        Thu, 28 Sep 2006 13:46:17 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id c1sm6242913nfe.2006.09.28.13.46.15;
        Thu, 28 Sep 2006 13:46:17 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28048>

Matthew L Foster wrote:
> --- Rogan Dawes <discard@dawes.za.net> wrote:
> 
>> I just don't think that any of the kernel developers feel the need to 
>> police any one else's clocks . . . they're more interested in the 
>> contents of the patch.
> 
> I am not saying git should "police any one else's clocks", I am saying git should be designed or
> configured in such a way, using local time, that it obviates the current reliance on everyone
> else's clock being set correctly. 

Sounds like you're suggesting that Git should not record any timestamps 
at all. After all, Git doesn't need them.
