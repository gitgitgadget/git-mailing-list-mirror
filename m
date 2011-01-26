From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 22:32:21 +0100
Message-ID: <m21v3zz6ze.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D3FFB0F.9070700@viscovery.net> <m2hbcvz8me.fsf@gmail.com>
	<AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
	<m2d3njz839.fsf@gmail.com> <7vei7zjr3y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCyg-0007ZP-3d
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1AZVc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:32:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36433 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab1AZVc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:32:27 -0500
Received: by wyb28 with SMTP id 28so1405622wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=gkQsE07Bu797WGUhruzrAWrwN/k6RZeJUCzfEtcOGX4=;
        b=JuqopNk08Yri3/Proj8ub/XzJCMM+1fUazOsZe6+W315ziDy23ziuD1u3SHg1bF3n5
         OwXmZc7lNBqU+j1HeXYInKkOZtvPmODdexG7WzexSTJ84xsa1o6hSVXR7gNpVnFMyphL
         RVovSE1xYFz7/rUAr3Nd3UfiQk1AJxtdsP+3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=LuVRiHyDApCXF8ienA0xQCTZ8du8VCaKCzIuv/uFBmPjBaWiBMdRFyUH3D+HK+D1aO
         kTTHzPpcm8Ut37oRtdRtS4MbFvEQGZ0J4FqTl6AuaRpu9J0vLDGMeIvX/IMzVgei7kfI
         CPRBZ47D/AneaeS/Roy2AU1jyh/IUPjwLqo1I=
Received: by 10.227.183.71 with SMTP id cf7mr78306wbb.195.1296077545806;
        Wed, 26 Jan 2011 13:32:25 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id y29sm6139235wbd.16.2011.01.26.13.32.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:32:24 -0800 (PST)
In-Reply-To: <7vei7zjr3y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 26 Jan 2011 13:24:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165551>

Junio C Hamano <gitster@pobox.com> writes:

> Francis Moreau <francis.moro@gmail.com> writes:
>
>>> On Wed, Jan 26, 2011 at 21:56, Francis Moreau <francis.moro@gmail.com> wrote:
>>>> Just out of curiosity, I'd like to know why, since it has no annoyance
>>>> for those who are replying to my emails.
>>>
>>> We keep everybody on CC who's interested in the thread here, and
>>> usually reply directly to the person whose email we respond to. In
>>> this case, I had to manually edit the TO line to be just you, and move
>>> everybody else to the CC.
>>
>> Well, if I decided to set Mail-Followup-To, that do mean that I don't
>> want you to do that !
>
> That is _not_ something for _you_ to unilaterally decide.
>
> I am responding to _you_ with this message to tell _you_ something, while
> keeping Sverre, J6t and Rene and the list in the loop.
>
> If I followedyour M-F-T on the message I am responding to, I would have
> ended up placing these "secondary" (for the purpose of my message) on my
> "To:" line.  That would make it impossible for them to prioritize the
> messages addressed directly to them (which would have their address on
> "To:") over other messages that they are merely in the loop (which would
> not have them on "To:"---their address may be on "Cc:" or they may be
> getting the message from the list).
>
> So please don't.

Agreed.

Should be fixed now, if not, please let me know.

Thanks
-- 
Francis
