From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Bad attitudes and problems in the Git community (was: Re: [PATCH
 2/2] Move sequencer to builtin)
Date: Mon, 10 Jun 2013 11:05:45 +0200
Message-ID: <51B596E9.9080307@gmail.com>
References: <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com> <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com> <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com> <20130609052624.GB561@sigill.intra.peff.net> <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com> <20130609174049.GA1039@sigill.intra.peff.net> <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com> <20130609181002.GC810@sigill.intra.peff.net> <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com> <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com> <51B4F6CA.8020807@alum.mit.edu> <51B51256.5060602@gmail.com> 
 <CAMP44s3qn2vTQ1oDnAe6m5AzZ_tAK0fe1=-nN=_=fv7TXGnMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 11:06:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uly37-0003TA-Ra
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 11:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab3FJJF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 05:05:58 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:55322 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab3FJJF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 05:05:56 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so1191435bkc.27
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=gndEyHgiBT9wjvf4/Oq2N/CBr4gLlkMjnd2wqBJx480=;
        b=HfA16r+UoPWxsn7fDDFWjM69pWof8AWMm7gRoHWp0U0LfFeuRCjsD3WkV5Z/y8/8j7
         ZNwdDmTsJcNyQprdPZwQWM/p8x/zIupDHwkC5z9bZtoa3g4D3+DqLD7micsYqNY+rEp6
         a/IgJLAheKy8qlJTUuZG4T/PCJNmu2KhXfH+akGgsSUZDEzkIniB+MSGzf5KGNwDdCV8
         ocJSNFs2+Vuil6MG84UOQNpicEIhPvCJLOUmcJZKTMHvkGgSuQCqa3hBGTy5euOLIsEz
         Tgc8Y8kDma05gOl00j1Rh1FO+eCp8kw8Q9ZWYSsv/9lBh9TqjVaWgzMWQlyQfdY05n0O
         QH2A==
X-Received: by 10.205.7.71 with SMTP id on7mr1344034bkb.23.1370855155157;
        Mon, 10 Jun 2013 02:05:55 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id jy7sm3235647bkb.6.2013.06.10.02.05.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 02:05:54 -0700 (PDT)
In-Reply-To: <CAMP44s3qn2vTQ1oDnAe6m5AzZ_tAK0fe1=-nN=_=fv7TXGnMbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227266>

On 06/10/2013 07:15 AM, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 6:40 PM, Stefano Lattarini
> <stefano.lattarini@gmail.com> wrote:
> 
>>   I do accuse Felipe's *attitude* to bring on and nourish such
>>   unpleasantness toxicity.  His technical merits and the possible
>>   qualities of his patches do *nothing* to remove or quell such
>>   issues.
> 
> How convenient to accuse me
>
I accuse your *attitude*, which IMHO is now even damaging your
code (that is, the acceptance of your code on the part of the
community).

> and not the others who have as much fault if not more.
>
Sorry, this is just your opinion.  Mine, by observing the proceeding
from the outside, is different: my opinion is that your attitude is
the problem.

> You need two sides to have an argument.
>
I disagree.  Unless you mean than, whenever a part behaves in a
hostile and aggressive way, the other part should just silently
knuckle under.

> The difference is; I did actually send code. Code that is good, code
> that works, and code that users need.
> 
As I said, as a *user* (since I'm definitely not a Git developer
in any sense of the word), I also need a calm and constructive
environment in the community.  Or are you interested only in
users that can benefit from things you are good at?

Regards,
  Stefano
