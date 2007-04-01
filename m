From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 3/3] Human friendly git: add another human readable option.
Date: Sun, 1 Apr 2007 09:38:23 +0200
Message-ID: <e5bfff550704010038g74173d2ekb78b2da41a5779c0@mail.gmail.com>
References: <7vk5wx556z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamamo" <junkio@cox.net>, git@vger.kernel.org
To: "Sloof Lirpa" <sitemaster@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 09:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXudx-0004gh-VB
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 09:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXDAHi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 03:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbXDAHi0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 03:38:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:60779 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbXDAHiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 03:38:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1235677uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 00:38:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CXUaiCBGgI11Kx7Q8fMhekJYqo+qEkAm1IjdxeyYoSkPRYWikNiZS9G0G2K/7frBKRelCAdBO+lcFrxIxW7/FJLaLLBvWkDhTpluRc1iBoez7WJIJPqk9gBesKs9yxZsaiyw0IXDfzKxL1e4sZgVMmgbobj1iH2LhmIzF9FyLh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ovmk9m/fPI8+lbmqn0mP5uVy18oCk5bufhhzaEUJfCcZmnFUxpOmZjWlyaqHDfbrevVAKAMZOEocbbq9RlquFZU/EQIMB3r++eBKjCcoa6LHITq3MrHYpvpxhSgqM2vk5Tsu02kWIafuxVFshxoUHD1LblJyEdGP577eT8Kdg7g=
Received: by 10.114.112.1 with SMTP id k1mr1351660wac.1175413103209;
        Sun, 01 Apr 2007 00:38:23 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Sun, 1 Apr 2007 00:38:23 -0700 (PDT)
In-Reply-To: <7vk5wx556z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43582>

On 4/1/07, Sloof Lirpa <sitemaster@cox.net> wrote:
> Building on top of the previous patches, this allows you to say:
>
>         $ git, please nicely ls-files
>
> to get a paginated output of ls-files.
>

When 'talking' to a computer I would rather prefer to type as less as
possible, but I understand it's a personal taste.

   Marco

P.S: What about git, c'mon gimme that f*** files!!

Please don't get hungry, just a joke ;-)
