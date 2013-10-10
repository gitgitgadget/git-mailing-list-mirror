From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [ANNOUNCE] git-related-0.1
Date: Fri, 11 Oct 2013 09:24:39 +1100
Message-ID: <CAH5451=LPy5ybu6n457NPcnf=Bbsv4jNyiO6ve=-T0qXJwq_bA@mail.gmail.com>
References: <CAMP44s0wPzV6FkfON4zazkOWqTB0qbpdEtruHD01NybtiK6-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 00:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUOfg-0006AI-Am
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 00:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab3JJWZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 18:25:21 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:38837 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab3JJWZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 18:25:20 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so184601vcb.21
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wj6TX1CwZr+YGmGdoC1WqC7UJhwlObLmRAKfJ+Z2r3k=;
        b=bbf7XHfwh5T05L7Hm6O2ZShnXTnP7PIXmeOoSNttMz8dtr1SJay/5Qgh61kGOo9MNG
         9YqfPFAv7eGAHbtJTD41ULz5+e2vUlqxlorJUARl5bo9MY+cCFv+5rybB0sNBLGG4ASx
         dRQvXtjQI3Ow8T7e9xNXGB2F9jBiXkJhVP54xSRzi2XP0n5ojWZnX94+4v+9zkO26czz
         EIT7KMSqcM531Y7QqOGrRq+WjWZDwaqGUYt3SAhw+enNelpSBqwdfodJFwyKRZIJ/AbB
         bTASokPsloPn6ofeHjxSRB22+4ncGjCZmrTvQeUVBoeIb1wmRH47ZqJfnFGmoSiYW/iZ
         Rt1g==
X-Received: by 10.52.35.20 with SMTP id d20mr12115120vdj.33.1381443919352;
 Thu, 10 Oct 2013 15:25:19 -0700 (PDT)
Received: by 10.220.58.197 with HTTP; Thu, 10 Oct 2013 15:24:39 -0700 (PDT)
In-Reply-To: <CAMP44s0wPzV6FkfON4zazkOWqTB0qbpdEtruHD01NybtiK6-Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235888>

On 11 October 2013 08:43, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> After gathering all the relevant
> people, it groups them to show what exactly was their role when the
> participated in the development of the relevant commit, and on how
> many relevant commits they participated.

It looks like you group by emails, any idea if anyone purposefully
uses the same email but a different name? I don't know if the email is
assumed to be the unique identifier, or if the name/email pair is,
however I think the typical use case is definitely to group by email
so it's a useful default behaviour.

> They are only displayed if
> they pass a minimum threshold of participation.

Out of interest, how is the threshold determined and is it configurable?

Regards,

Andrew Ardill
