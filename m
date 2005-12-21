From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 18:10:16 +1300
Message-ID: <46a038f90512202110i5f4a4d6fu16981f5801798717@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	 <7vr787dp9r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 06:11:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EowF7-0000qB-9a
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVLUFKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVLUFKS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:10:18 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:49701 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbVLUFKR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:10:17 -0500
Received: by wproxy.gmail.com with SMTP id 57so58856wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 21:10:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wa7Sh4zYGsFi9shMIKNOHxI8IHFSR1EjeJla4TdX6clAB1nvPeIBE4XHTlcv7ALOF3SbIjbAryBjVmMIpY330vZGcRH/2wGacQmo/knkMLCR9dT2Ki7YxUXDZVQnlBqgYb9vQ5NySy0Xirlk3dd5nHPjdcahznw8rOFe6cvY8eU=
Received: by 10.54.114.7 with SMTP id m7mr432921wrc;
        Tue, 20 Dec 2005 21:10:16 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 21:10:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr787dp9r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13865>

On 12/21/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
> > I think I owe you an apology and a couple of beers...
>
> Nah, you do not owe me anything.  Does something like this look
> good?

Yup, makes sense to me. I often explain it as "same file permissions
and access model as you'd use with CVS".

cheers,


martin
