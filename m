From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Confused about diff-tree --cc output
Date: Thu, 5 Feb 2009 03:57:16 -0500
Message-ID: <76718490902050057u1edb1cffu8f0f8d7cd33f4d42@mail.gmail.com>
References: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
	 <7vk585n9x8.fsf@gitster.siamese.dyndns.org>
	 <76718490902041949v8fffd17l7cb19d836a3e1887@mail.gmail.com>
	 <7vmyd1ffcv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV04K-0006jm-6B
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZBEI5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZBEI5R
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:57:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:35055 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbZBEI5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:57:16 -0500
Received: by rv-out-0506.google.com with SMTP id k40so158428rvb.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zo7gmz7UB6nKkhxuplvLLHneGzc6fPGpX3DHHlo3F3A=;
        b=r6YMxwIeWOxWctNuQcIQTHtBlD022kYcvXd+bFOtoyRgvyhuB84osk5WCF5rDqD5aQ
         zIADQJ2XqUI4iX7psNSbi8Sk6bIRsaGN65Csqk7s7wBaGQGxISgg6z4DJaiDQU+0I8Yn
         92QbXDTRy3fueUtroJmazXyl9BecwXRwyaSoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o1051ZoQR98WDiu3ZuVkIQOfVSXl4hYiuNog0X1XYWPAKDRoiFYNHzz8+LU+Po3s1G
         tqyzxrCuvK+AojDIZUCCTjzIqgt3G+ZiOKJqQD+X7CopjBYiZb3QnFqgiuQ6gEOmHg1M
         QLvHZ35e8Kij0DrBTc60Dt754VsqAVmiqoMFo=
Received: by 10.141.142.1 with SMTP id u1mr179744rvn.129.1233824236094; Thu, 
	05 Feb 2009 00:57:16 -0800 (PST)
In-Reply-To: <7vmyd1ffcv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108542>

On Thu, Feb 5, 2009 at 3:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Is that about right?
>
> Yes, not just about right but it is how it works.

Got it. I did read the thread you pointed me to earlier, but I had to
work through it w/my example to make sure I understood completely. I
appreciate your patience.

j.
