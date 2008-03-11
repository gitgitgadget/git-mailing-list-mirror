From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 13:17:57 +0800
Message-ID: <46dff0320803102217s39f290c3k1f627a638b7aebf5@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803102018k2f1dd9e0k6b766671f36ff5f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 06:18:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYwso-0001n9-16
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 06:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYCKFR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 01:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYCKFR7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 01:17:59 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:47159 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbYCKFR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 01:17:58 -0400
Received: by an-out-0708.google.com with SMTP id d31so543956and.103
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 22:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/6tA+lznY9cCKu+AHXF0VZ3NXvrWWT9NxO7fWAy0KkI=;
        b=pgYu1yFdYUNcMKcZRXS4FM4Ove3QGcd/lFmWmHbLnURg/hcP/O4elwRzfcF7EXmqObsJj++gEQGzeKvr0UBiNTrqiSohDRNNTpASghelF/hVYtPwbrPcnAdYlIYEA8zGohTK1wZebNXqY+Zas4994cagkORnIUYPjyoB2rr2YCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U/GHA4OQndE55jxRVe8WnXDmbeFFV9WETeQtFHahn39t2OwolWhDbVd5+iaqpvQWL4Zfet6TL3dmTUZU7+2vl86NEOtzphAXdEEbFq086K+oilD/7y7lqShGd8xVdnzDAtQ+0/AzCVuYEyn6GTMrDEjN35hkLs8a1/LaiaYHHsA=
Received: by 10.100.46.10 with SMTP id t10mr12532457ant.53.1205212677805;
        Mon, 10 Mar 2008 22:17:57 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Mon, 10 Mar 2008 22:17:57 -0700 (PDT)
In-Reply-To: <402c10cd0803102018k2f1dd9e0k6b766671f36ff5f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76796>

On Tue, Mar 11, 2008 at 11:18 AM, Sverre Hvammen Johansen
<hvammen@gmail.com> wrote:
> Hi,
>
>  I have split the original patch I had for the fast forward strategies
>  in two.  I hope to get something close to this patch accepted.  I need
>  this feature for the Accurev integration I am working on.  I will be
>  able to spend time on this the next two weeks.
>

Expecting it will be accepted. It's a useful feature for me.

>
>  --
>  Sverre Hvammen Johansen
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
