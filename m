From: "Aubrey Li" <aubreylee@gmail.com>
Subject: Re: git proxy issue
Date: Mon, 16 Jul 2007 11:55:10 +0800
Message-ID: <6d6a94c50707152055m4a8e24b8v7dc90101316e6b88@mail.gmail.com>
References: <6d6a94c50707151921h7f2a65fes65c94c3c1090937a@mail.gmail.com>
	 <7vk5t1avcn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAHgJ-0003wx-PL
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760460AbXGPDzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760418AbXGPDzN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:55:13 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:42663 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760460AbXGPDzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:55:11 -0400
Received: by nz-out-0506.google.com with SMTP id s18so723534nze
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 20:55:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qo2Cy1fma693IAqUJTyjVldE2oXRFReIc/U2zaI7CF3ZuGAQaBVhFyrjPIlkGFff+Wajif7AbdxtOVS+AGCuEULmTLUi0KlE7J85WllxCrMDufQRkvsoY82ME44BY9Js7jNHIaLMLj6B/9nCn7SmSMUXGmokfFMlKUR86XAEIsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QGFQl5PyWiCulSHUSHs6g3DLBBLt0V8qb+rNnCovwTpkBgSxbWAyBggZ2wloofuDfg3rfuMnvEHayG1MNkXhkDqWa6QlsSGUEUAdaOWexIJhocxAwEc1exfebi/oqHyggGXGz1GGgJcA+7dDHTtIpqktaOBOtY+sfSSwTbVT8HE=
Received: by 10.142.84.3 with SMTP id h3mr287439wfb.1184558110474;
        Sun, 15 Jul 2007 20:55:10 -0700 (PDT)
Received: by 10.142.99.20 with HTTP; Sun, 15 Jul 2007 20:55:10 -0700 (PDT)
In-Reply-To: <7vk5t1avcn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52632>

On 7/16/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Aubrey Li" <aubreylee@gmail.com> writes:
>
> > From which release version git proxy is supported?
>
> v0.99.9k (Nov 25 2005) is the first tagged release (the patch
> itself was from Nov 4 2005).
>
>
oh, so how to config it?
Thanks,
-Aubrey
