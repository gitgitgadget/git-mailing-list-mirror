From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 18:07:15 +1200
Message-ID: <46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	 <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcEwm-0002ho-7C
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 08:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXDMGHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 02:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbXDMGHS
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 02:07:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:53733 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXDMGHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 02:07:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so784569wxd
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 23:07:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dV6tIBsSnwuoG5Y7gio5ckhh4E+24+569/a48YuJTVeZyoXDvaLYQulaH0vjcV6mfn1jItFjMne0RQY2jkKzBLZaG69taeSkv8tneKg1V3jY9ehWPbgDFIDlKSn1FTAlUZZNfy/pgD9cHWXZnTIT55J29obYhaeHqnZEu95Q/P8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZDM4czG9cjiEmy/v7CId7HunScqiCs1KTYouSvQ80kiBjcObekpBkbkNBiwsMdF/QIL7y0FlkynVmGdlgljzQcOI0O5Tk4FMjnNPKtZKnjt1EL4R8r0SaootaYF00mZLNChrvWBGt01BoUmjcmb3ZPMDPYcIAYJS0I5S8V/udUA=
Received: by 10.90.90.3 with SMTP id n3mr2718874agb.1176444435974;
        Thu, 12 Apr 2007 23:07:15 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Thu, 12 Apr 2007 23:07:15 -0700 (PDT)
In-Reply-To: <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44389>

On 4/13/07, Paul Mackerras <paulus@samba.org> wrote:
> Side-by-side would be more challenging.

<wish>If someone gets started on side-by-side, I'd love to have
char-level diff colouring, like xxdiff does. Oh, and chocolate
icecream too.</wish>

If there's enough rope to get started, I'll be happy to hack it into place.

cheers,


m
