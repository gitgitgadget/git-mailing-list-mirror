From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v8 0/5] Reroll patches against Git v1.8.3.2
Date: Thu, 4 Jul 2013 00:03:04 +0400
Message-ID: <20130703200304.GA32573@dell-note>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
 <cover.1372719264.git.Alex.Crezoff@gmail.com>
 <7vbo6klpgw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTGk-0007kU-HF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039Ab3GCUDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:03:10 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:47728 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCUDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:03:09 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so557398lbi.25
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LUFYbywT62iwFTN1EYD3j8soaMFqr80FVisLe0q/ABk=;
        b=accmk0RhVaMrxuiCvZxtI9SE/9bl5Kf/yfFoV4cXfn2EXC0RDmvXq/3vJpB3MPYOgI
         SjcBF1otK75dwXq5BF8dNAkWrd1zVACubm4fbiKwoFFq3EEymzVme1winyaXJ7haYHCg
         L6Div7f7VBof7tlJy5z+MUYo0lKWfCNwbQE3C1a+lcCqigRPSQtJeNKZkAlKX38W8iq7
         QcsLpuWCawyCxVkfvXnBzWSsuQzHYrjaqC+ohG3dHa7rI7k5auEZfs900lYQagzBoyAd
         FZt+YRidLe7Gd+se7vcYeOL+zHs2x55C5nwSrqzkmV2my3DDxpcf7RLQz9/kbPKEsDgH
         Nm9g==
X-Received: by 10.152.4.137 with SMTP id k9mr1278104lak.11.1372881787307;
        Wed, 03 Jul 2013 13:03:07 -0700 (PDT)
Received: from localhost (ppp91-77-20-80.pppoe.mtu-net.ru. [91.77.20.80])
        by mx.google.com with ESMTPSA id x8sm11428548lae.10.2013.07.03.13.03.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 13:03:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbo6klpgw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229518>

On Tue, Jul 02, 2013 at 12:41:03PM -0700, Junio C Hamano wrote:
> Alexey Shumkin <Alex.Crezoff@gmail.com> writes:
> 
> > v8 of this patch series includes the following changes against v7:
> 
> Oops, isn't this already in 'next'?  In that case, please feed
> incremental updates on top of the patches that are already queued as
> improvements and fixes.
Oops ;)
I'll send patches against 'next' then.
> 
> Thanks.
