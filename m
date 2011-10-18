From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Compiling on Windows
Date: Tue, 18 Oct 2011 17:17:24 +1100
Message-ID: <CAH5451=VPzkFZyyUUdj+=dXDCHKQbWTTob_=JJFBCwaDsp1n7Q@mail.gmail.com>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
 <op.v3i8rauz0aolir@keputer.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 08:17:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG2zp-0000M6-Do
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 08:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab1JRGRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 02:17:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47927 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1JRGRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 02:17:45 -0400
Received: by bkbzt19 with SMTP id zt19so398235bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pTAEyrPevcopNmbN+xgR9ixofQvufKBGf4kTVWcCQvo=;
        b=BU/GmIk20vR8ohNhPvzVvEUJ3mdOpTI1qOAoQTnal5ytIhIurjU5gzBOKA5DWt1d7x
         5Kr9cIzXZeDLTDw7DkS/JP8pt0LELeZXpeBKSFaiTpk99MSTrp+nH7f24qi7YumQY0l1
         Op4BmjK4BcB/AEweZsenkQek25n61PRrLTZic=
Received: by 10.223.57.139 with SMTP id c11mr1964883fah.24.1318918664249; Mon,
 17 Oct 2011 23:17:44 -0700 (PDT)
Received: by 10.152.13.100 with HTTP; Mon, 17 Oct 2011 23:17:24 -0700 (PDT)
In-Reply-To: <op.v3i8rauz0aolir@keputer.lokaal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183860>

Thanks for the replies all - I think my main issue was that the wiki
is down and msysgit has very little use-able documentation otherwise.
I had cloned the msysgit project, but was lost on what to do from
there. Foolishly, I had glossed over the msysgit installers on the
project home (I think I thought they were Git for Windows installers).

I have now installed everything, and am ready to hack. Perhaps the
first port of call is adding a README to msysgit :D

Thanks again,

Andrew Ardill
