From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:42:25 -0400
Message-ID: <46a038f91003181242ifb3d0bao553c5be5e6a4f25c@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com> 
	<alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
	<b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLcJ-0007LF-Ep
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab0CRTmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:42:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55775 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0CRTmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:42:46 -0400
Received: by gyg8 with SMTP id 8so1203274gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=5WyLPhnspI4unfaP3/8aoneIvq2zdCYDxYBO8wM3U6Q=;
        b=OINEXGTrtnYW3Sp1MlEmpJ53IdY9Wq7JmYfbkvKN53nYP1uDgEmj22RJQ4k5z2RbuM
         c6G4OaiNlQ9fcfTWy18kBlplxWmYyF8RQ4czBUGWkSKEothiYjR+IMm39Dvn/ytQo9WK
         sNZScKjUQ3wELAjGKF3XzCxkBiPAgZAb40QbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DDE1P36nxRzbn7QBs66w2RZJoZPPcwvJaVVT+XOY9dbuQBAWpjy4F0W57XC9TQbBs5
         6kOuWpM4bRoom4qsD0OTvi0EsT1PitfE60GOsxu9dt/TQezO/rtz3hm4Cs3Ioxaxr38d
         VIWV0IhEEW0bgiFHpJaDfwHy52OPrtkCCYUUI=
Received: by 10.100.22.32 with SMTP id 32mr4928439anv.153.1268941365118; Thu, 
	18 Mar 2010 12:42:45 -0700 (PDT)
In-Reply-To: <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142504>

On Thu, Mar 18, 2010 at 3:32 PM, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 14:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>
>> And if it doesn't have meaning, then it's just
>> annoying and will never ever be attached to
>> anything relevant long-term.
>
> You've actually just described the current name/email system.

WTH are you drinking? I have been using my current name and email
accounts for many years.

They are useful for git and for some things that are even more useful
-- like addressing emails! My best CV is googing for my name / email
addresses -- it will show you my professional career. Including the
time that Linus called my patch "idiotic" :-)

So, these things are attached to something meaningful: my long term
personal identity. A git-only "uuid"? Screw that, I hack on too many
physically different machines, I am not going to be carrying around a
magic string.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
