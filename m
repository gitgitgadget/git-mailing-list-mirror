From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: How to merge branches except for one commit
Date: Thu, 29 May 2008 10:38:21 +0600
Message-ID: <7bfdc29a0805282138kabc5417i4f67ae3995bf238c@mail.gmail.com>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
	 <7vhcchrb43.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andrew Arnott" <andrewarnott@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 06:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Zv1-0003sX-33
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 06:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYE2EiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 00:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYE2EiX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 00:38:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:1485 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYE2EiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 00:38:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2161308ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 21:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4lnNnFQY7rMXxuaFHX4BOU/zR6zDQwlqUSsdlZLM5uc=;
        b=VYm61Scjs+RPGbmI5HRaXofz2AUcCRGIUrh/6ixZbKVdwB2+fsd3orshb/uwOkJa2XiufgRYkj6pLCmEcajN79sR0KArTOBHZauaB16VXERS396e0aOXxU/xe2AY6TSWbwkd8gMKeLAas+XgYOEkeujlSSz28Wwqt1YhpwTOhkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IFql7yt0dZRJvH/zztqwJkheqgk934kwyEmo0BnZegWCtLPLAQGG7uG/aCpWWrzX2WMv3gclb3KOIr+fgQyUZ0d/vCrXsL6IqH+8wz+2KA7FN89ogQJ/7dDnqr8i1LwZKqcIY6ZPT8jgYZ0xm7YYDcOW1fmlwLDK0YVr1WMssSM=
Received: by 10.151.112.5 with SMTP id p5mr6360532ybm.159.1212035901438;
        Wed, 28 May 2008 21:38:21 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Wed, 28 May 2008 21:38:21 -0700 (PDT)
In-Reply-To: <7vhcchrb43.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83174>

>
> You can never plan ahead perfectly, so do not be too hard on yourself if
> you occasionally screw up.  Cherry-picking from time to time is Ok.  With
> practice, you will get used to it.  I juggle 5 integration branches to
> maintain git.git itself and it took some practice for me to get
> comfortable with the workflow.
>

I always wanted to know how you did it, thanks for sharing it :).

Best regards,

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
