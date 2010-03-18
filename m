From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 18:44:17 -0500
Message-ID: <b4087cc51003181644j45722911u87d4cb62a9b4ea09@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com> 
	<46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com> 
	<b4087cc51003181502y1f339cf8u268fa5388ace098@mail.gmail.com> 
	<alpine.LFD.2.00.1003181935070.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:44:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPON-0002vo-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0CRXoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 19:44:38 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:60598 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0CRXoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 19:44:38 -0400
Received: by mail-fx0-f219.google.com with SMTP id 19so176773fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=StIWRrnlmR5hhRpA1w/x9u1zaApPTKceCDyPmG1NIa4=;
        b=S9cvMlMzz43kVdXIaq0Vp8QxI7RLTxnN2IubSXl2A4O1+CzxN+wDFEm4x3vNjdocPD
         Iyp2IjxdfiCEiTwFLyFpeLeXJQFd2OeUxUnnamouUeNr5O4Th43bxBL0Vu6/lCwilire
         SKn0L4RVuFbkIfiryqjDgOtmkMqFwyQUCdrsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=daxFpk0nxtMFhOPkQ3EmGUrUWaPSZf+w9rFDwRWFaBiKvba9XRVUP3EQ+5sRaX0kx9
         r8m9qNWj3o+06GC0KyssgdWDWK+Nrg3yHlDv+2IrqgrvN2NoZQ0s/BD7yJy7ATPQwmfB
         bE342/F/cWf0sRkjjBauWQaIC3Ag1hwdEbTXk=
Received: by 10.239.189.76 with SMTP id s12mr1474284hbh.111.1268955877100; 
	Thu, 18 Mar 2010 16:44:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181935070.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142540>

On Thu, Mar 18, 2010 at 18:37, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 18 Mar 2010, Michael Witten wrote:
>
>> You missed the other line (probably gmail's fault):
>>
>> Most likely, all that will happen is identification entropy won't
>> increase nearly so rapidly and there might be other benefits
>> such as shortlog speed improvements.
>
> The shortlog speed improvement is certainly not going to compensate for
> all the added human time needed to process the extra piece of
> information.

What added human time?
