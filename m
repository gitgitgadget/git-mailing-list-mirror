From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: msysgit list vs. git list
Date: Sat, 11 Aug 2007 22:30:58 -0700
Message-ID: <A81033F5A41C44638DB51C59D3F7863C@ntdev.corp.microsoft.com>
References: <4DCDB012-2594-4EAE-9F5E-76EC68E60BE5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 07:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK62e-0002Ua-S5
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 07:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXHLFbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 01:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXHLFbB
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 01:31:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:15727 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXHLFbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 01:31:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1428745wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 22:31:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=f981+GFRr2hpF2sNCdCsd368t1t403SY/FGcx42IR9qxQTOtJKENTPCv1E5EwMBdv4u0FRph/bSUF9akY2LiOheIWSj6fSH0PAvK4QioFOweVdYwVtSu+/PHGmNKcFfTiLvJstYaKqwmYXWljfum+arnQC4IpSp2cL0gVM0cSY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=fHfTRQL5FH2Mpyvh4y3tC4naMy0pXZtQjhSkdtrvCH2WPpP4xQ/Vi/FPqGiAFCTI2nY4WrrZPSa0IjXkTLBxochMqMLMm8YmmIYF+2W0J16z8EuC7kMb9Os6+GULzGX9Ks+5OeDmojCi3GXbxEPbtSg3rmHWXmaxIEke7w/bZpE=
Received: by 10.114.103.1 with SMTP id a1mr4082267wac.1186896659932;
        Sat, 11 Aug 2007 22:30:59 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j26sm4938163waf.2007.08.11.22.30.59
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Aug 2007 22:30:59 -0700 (PDT)
In-Reply-To: <4DCDB012-2594-4EAE-9F5E-76EC68E60BE5@zib.de>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MIMEOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55663>

----- Original Message ----- 
From: "Steffen Prohaska" <prohaska@zib.de>
> Could someone briefly explain the scope of the msysgit list.
> 
> When should I post to the msysgit git?

When issue is specific to MinGW port of Git

> When to the git list?

When its a general Git issue

> When to both lists?
Never?

> If the traffic on msysgit is not too high, wouldn't it be
> more reasonable just to use the git list and indicate in
> the subject that the post is primarily related to msysgit?

It depends. We use msysgit to discuss issues that are totally uninteresting to the rest of git community.
Like discussion of specific bugs etc.
On the other hand we do read this list as well, so it's your call.

- Dmitry
