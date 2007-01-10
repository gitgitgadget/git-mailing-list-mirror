From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 22:26:34 +0100
Message-ID: <81b0412b0701101326p11069c76w2873106cb2d46ebf@mail.gmail.com>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 22:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4kxz-0002OC-Af
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 22:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbXAJV0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXAJV0g
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 16:26:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:19260 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965113AbXAJV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 16:26:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so235097uga
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 13:26:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kV784y39aFM1laETt3feY2O5VYez8C3rLuU8qwZerix2DnzjUlkYjtGVLO3lRfd0ysY28Gllj1fSdq2CIX9vHedIfwqDow5o2RUl3ckJ/SWd3JfxkjdZqRWmKbXKLVE+rP9fxmkJJfn+wti3TWf9apyYJZTTgyfImmRo4l8iqUo=
Received: by 10.78.183.15 with SMTP id g15mr260681huf.1168464394191;
        Wed, 10 Jan 2007 13:26:34 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 13:26:34 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36531>

On 1/10/07, Junio C Hamano <junkio@cox.net> wrote:
>
> I would prefer it to be rather automatic -- how about this instead?
>
...
> +ifneq (,$X)

Perfect! :)
