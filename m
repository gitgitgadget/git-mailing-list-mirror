From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Fri, 2 Apr 2010 23:38:03 -0400
Message-ID: <u2s76c5b8581004022038rf8aa0017l5dea55689c738fd9@mail.gmail.com>
References: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
	 <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 05:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxuGR-00085r-DY
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 05:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab0DCDnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 23:43:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52655 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab0DCDnH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 23:43:07 -0400
Received: by gwb19 with SMTP id 19so444760gwb.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=HnnhVVaDi/iJkEImb90D2rnaQwkcWuOQdXOgQYCsMNs=;
        b=RDJpeRdm9BoyqHubzq0Z8AQ/ETjhdQVgadjNzIsUhmSNCI6WmUBsZdfnlR0mwCOWFo
         DFT5PzZlj96H+5BzJevz9EclUlFupdnzIRUDCnwh26Dw1MPIdYvBY3Hv0Y+IZua0koE8
         eUezkIzc2CpxQeNbQNR1wmVcSrYPFMivE/HAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=aX5vD4tgpqa0gNqHj3zAPd0nGtJmZSava6aNaM/ARnzC1JkI/pTHj3tuGZWc8pi23B
         nyTOZnLWkOA0yfTgwx1IyBCPElKQInBGeY5dQLQK3pxDsXO3AsvlkuiCJSNQ/NuSutfc
         gWGIcvL2+Sb+uW+0aWTrEOparaeH+P6AUEd7c=
Received: by 10.231.155.143 with HTTP; Fri, 2 Apr 2010 20:38:03 -0700 (PDT)
In-Reply-To: <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
Received: by 10.150.141.8 with SMTP id o8mr1226419ybd.304.1270265884012; Fri, 
	02 Apr 2010 20:38:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143876>

Hi,

Can, please, somebody advise what do i have to do in the situation
described below?

Thanks,
Eugene

On Thu, Apr 1, 2010 at 10:08 PM, Eugene Sajine <euguess@gmail.com> wrot=
e:
> Hi,
>
> I was running git gc weekly on my machine and today for some reason i=
t
> failed on one of my repos with an error saying
>
> Error: cannot lock ref =E2=80=98RENAMED-REF..1=E2=80=99
> Error: failed to run ref-log
>
> The problem is I have no idea what it is talking about=E2=80=A6 =E2=80=
=9Cgit show-ref=E2=80=9D
> doesn=E2=80=99t show anything even close to this name. Fools day joke=
?;)
> Any advice?
>
> Thanks in advance,
> Eugene
>
