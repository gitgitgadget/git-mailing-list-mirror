From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 22:08:26 +0100
Message-ID: <m2d3njz839.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D3FFB0F.9070700@viscovery.net> <m2hbcvz8me.fsf@gmail.com>
	<AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCbX-0002X2-8P
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab1AZVIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:08:34 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44601 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab1AZVId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:08:33 -0500
Received: by wyb28 with SMTP id 28so1381935wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:mail-followup-to
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=n84CONL3jpzSTD8JA17/wSzi1OqR8rh3nOHUF0ZTgyY=;
        b=vr+8YvBe1YF0MdKVMg+PlFXFHYTOuA1u4QDC/1QkqYXen6irW0bVjUlZ0lD9MjY9Bs
         yWEVt0L096uhBmX7ubabui/Fkl9MMok709Pc/+6amUnVJyBq3AsSfj3WBoV2UxG4R5oK
         SIvYUuodFzzPXvQDnVs+tljQQpB2E381xEc3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=fknlYOJ+hVnhW7itUAx0F7Ri5/Gc48GALDaN10OU0s1+IrjFaRX7akPyUH2aRFMvoh
         6I1EhdJf8n7URMywhoeKdJ+DWbZQH8rl1t1uIapDEw7wnr+S8P+I59VR/1paNqWx5SRD
         KkgexUPwm1m9dvWlSfw/zTzhXJO8Sv/10Yn+A=
Received: by 10.216.17.204 with SMTP id j54mr5628767wej.32.1296076112021;
        Wed, 26 Jan 2011 13:08:32 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id n78sm8009884weq.3.2011.01.26.13.08.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:08:30 -0800 (PST)
Mail-Followup-To: Sverre Rabbelier <srabbelier@gmail.com>, Johannes Sixt
	<j.sixt@viscovery.net>, git@vger.kernel.org, =?iso-8859-1?Q?Ren=E9?=
 Scharfe
	<rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 26 Jan 2011 22:03:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165547>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Jan 26, 2011 at 21:56, Francis Moreau <francis.moro@gmail.com> wrote:
>> Just out of curiosity, I'd like to know why, since it has no annoyance
>> for those who are replying to my emails.
>
> We keep everybody on CC who's interested in the thread here, and
> usually reply directly to the person whose email we respond to. In
> this case, I had to manually edit the TO line to be just you, and move
> everybody else to the CC.

Well, if I decided to set Mail-Followup-To, that do mean that I don't
want you to do that !

-- 
Francis
