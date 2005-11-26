From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 1/9] archimport: first, make sure it still compiles
Date: Sat, 26 Nov 2005 10:51:14 +0000
Message-ID: <46a038f90511260251x7c470c2esc6e87048cf8eda6b@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
	 <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	 <20051124074605.GA4789@mail.yhbt.net>
	 <20051124074739.GB4789@mail.yhbt.net>
	 <Pine.LNX.4.64.0511241051170.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Nov 26 11:52:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efxea-00087q-Sc
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 11:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKZKvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 05:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKZKvR
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 05:51:17 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:40609 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750808AbVKZKvQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 05:51:16 -0500
Received: by zproxy.gmail.com with SMTP id 18so1900083nzp
        for <git@vger.kernel.org>; Sat, 26 Nov 2005 02:51:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AI4YH2hpdd8pPiPhasurR68W71K/vjgbxTAky9EMGCZzkPRLJdUnBP1wPm6/bhCLsXl5DUClryUPQ2bIKwXBA3MkA+7AT7XrDaDYliGqRWJAkfXrNuyoDq5E8+u2XWMhVmYIZDVzWzYmxrY3vIsRdkvRZhmgFm9gL5yEH8QWd5s=
Received: by 10.65.61.11 with SMTP id o11mr2306003qbk;
        Sat, 26 Nov 2005 02:51:14 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Sat, 26 Nov 2005 02:51:14 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511241051170.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12778>

On 11/24/05, Linus Torvalds <torvalds@osdl.org> wrote:
>  I don't know about Junio, but if I were him, I'd have preferred that all
> your patches had a
>
>         archimport: ..
>
> prefix in the subject line, not just the first one.

Good catch -- I'll prefix them all as I merge them. If Junio pulls
from my tree, he'll get them prefixed.

cheers,



martin
