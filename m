From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:00:21 -0500
Message-ID: <b4087cc51003181300x5aab9033yde20bff12b7ff289@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com> 
	<alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
	<b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com> 
	<alpine.LFD.2.00.1003181237450.18017@i5.linux-foundation.org> 
	<b4087cc51003181247m26125efft3d03cd34a2dc9280@mail.gmail.com> 
	<alpine.LFD.2.00.1003181250200.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLth-00080A-0M
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab0CRUAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 16:00:44 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:35245 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab0CRUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 16:00:43 -0400
Received: by fxm19 with SMTP id 19so6847fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AprO9PjgAnLYKgzUKSitjwHs8FKbxQTi19f+YC4x7mA=;
        b=D4S8a82D5h+ehvkJullOv8gJAXax3FO9EiD08x8KfV2VUAQ4gEaT4NI4tn69doBxp9
         W/TYApH4koIr0G62RO/efaBl0s6S0fMjjjwnjZmu5l6M5FpfOv3s2fgeLDG9/jUCTnYN
         e8pZa583dovRxawf7Yt6x1/O3n0p80K+L/bcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kwffTT+4gxmSvPTXaBvTukTb/zITEaXuDkEm0PDEnf5Y1aZxmMYXd7xZu7N2ZhgrmU
         HHIfT46sQf1Fqtbu4NGaeFtFjWhBjeUs5OWr6yJFEdn4eD+2kh28JSst1SXMnEKNOKwh
         DtbDfrypXnldVilsK4ddh08cA/6mivMX2tzpc=
Received: by 10.239.187.210 with SMTP id m18mr766359hbh.19.1268942441136; Thu, 
	18 Mar 2010 13:00:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181250200.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142511>

On Thu, Mar 18, 2010 at 14:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you like the random 16-letter jumbles, then for christ sake JUST CHANGE
> "git log" to hash the author name for you. You'll get the uuid's. What I'm
> telling you is that NOBODY SANE WANTS TO EVER SEE THEM.

No, I'm reasonably certain you didn't.
