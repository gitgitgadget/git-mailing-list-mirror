From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Update git-annotate/git-blame documentation
Date: Mon, 16 Apr 2007 09:24:08 +0200
Message-ID: <81b0412b0704160024i4c202efey5eb54d382d003bbd@mail.gmail.com>
References: <20070416053525.GA18821@localdomain>
	 <20070416062034.GC19759@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Andrew Ruder" <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLZO-0005Zz-2B
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbXDPHYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbXDPHYK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:24:10 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:30874 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbXDPHYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:24:09 -0400
Received: by an-out-0708.google.com with SMTP id b33so1632570ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 00:24:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecLZL69H7YZqs1bKQwKsqxn9ymm7Tlqg4hj9m1vq5Csc4y7wyS73nX0cKI4V0AeWrtY6WKZHArnV/33W+UVgZnFDWQsNO+/+W/CmnfZK80jUbSS2u8WaNFrA13FAFazVTOCTckgQ6vrKizhFQ1cU3xy+Anv2x0YK0MfBJqAjPWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tFz90hn+FDbMB1oAb1KpMgOtMOF+muz/wCmbv5cXbcwnsZg3depwuXR1OFJ4wIoYY8JIdOMTlQWkM7YX5TXAZdto5lp9943Z+WcIU+QCqAiVrtXwchIwgeGMCqA5O1mRakHC2SXEvVAojys3qBLeKjHUMPiZ26iMzwod3pjtkLY=
Received: by 10.100.33.14 with SMTP id g14mr4265035ang.1176708248824;
        Mon, 16 Apr 2007 00:24:08 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 00:24:08 -0700 (PDT)
In-Reply-To: <20070416062034.GC19759@localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44602>

On 4/16/07, Andrew Ruder <andy@aeruder.net> wrote:
> +-L n,m::
> +       Annotate only the specified line range (lines count from 1).
> +
> +-l::
> +       Show long rev (Default: off).
> +
> +-t::
> +       Show raw timestamp (Default: off).

Very nice, mentioning this small details. Thanks!
