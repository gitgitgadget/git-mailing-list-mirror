From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sun, 1 Mar 2009 02:05:52 -0500
Message-ID: <76718490902282305m127eb901xac9495f3877cce47@mail.gmail.com>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
	 <7vsklycct9.fsf@gitster.siamese.dyndns.org>
	 <20090301153000.6117@nanako3.lavabit.com>
	 <76718490902282259q39da4267r34d169ec200704ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 08:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldfli-0003KT-GG
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 08:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbZCAHFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 02:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZCAHFy
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 02:05:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:51548 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZCAHFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 02:05:54 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1805952rvb.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9wp75r6Udcau6kiQKACMKw7kvYpoKPD7I6L3GciGDg0=;
        b=LuD8zi8vA4SzH1+fCwtp2P08bLguy2SL0Mm8LB8cDxRx2yWJaj7YsiNKLM6ANbHk0O
         Elbt1mSEsmoav5JYO07kGryJMExs9+rP8Oeu7VhggPfvXLjgCPcoZusQPnerEeWh3bJf
         aEFK1jYcJvaaD5cAN13ZfyDPAUwNz+OvuKCF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f3bIq2hhRAqXy9IjrgtsgWFla71FoW+8kz3/YojgTH95X5A6wD6MVfCr4nUKp20Y/E
         7OAyMgDimj4/DyQPr7RMX3IL4EREsDefba48y8pwCRw1Sp1f7YMXDzNGHYuuCedN+zxA
         7YXZJI4ZkW1yeTiONHOtLxtoLJWFfa38DuWxs=
Received: by 10.141.76.21 with SMTP id d21mr2220217rvl.34.1235891152202; Sat, 
	28 Feb 2009 23:05:52 -0800 (PST)
In-Reply-To: <76718490902282259q39da4267r34d169ec200704ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111824>

On Sun, Mar 1, 2009 at 1:59 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> fun, so I was going to see if it was reasonable to link format-patch
> against msmtp. OTOH, I don't want to bloat the git binary, so it may

And msmtp is GPLv3, so nevermind anyway.

j.
