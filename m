From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Bad attitudes and problems in the Git community (was: Re: [PATCH
 2/2] Move sequencer to builtin)
Date: Mon, 10 Jun 2013 14:33:16 -0400
Message-ID: <CACPiFCKJCfw3UDz0jUvE_E-qTvgN_Y3ut_mi_ZubEpxqFdTJYA@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net> <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
 <20130609174049.GA1039@sigill.intra.peff.net> <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
 <20130609181002.GC810@sigill.intra.peff.net> <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
 <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
 <51B4F6CA.8020807@alum.mit.edu> <51B51256.5060602@gmail.com>
 <CAMP44s3qn2vTQ1oDnAe6m5AzZ_tAK0fe1=-nN=_=fv7TXGnMbw@mail.gmail.com>
 <51B596E9.9080307@gmail.com> <CAMP44s3LXrp5_6eHvsFp-4oyoX5FQY0TF_w+ZfQXNS89YzaXaQ@mail.gmail.com>
 <CANiSa6iTJuXnKTL50GOv7b=pLLUqA4vc-EsSLi3trh4Ehh3xTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6uT-0003CG-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab3FJSdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:33:38 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:49443 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab3FJSdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:33:37 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so2483656qab.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QOz6nl7XxAW9xEtxsvPnPbM6oDI4FTSQ/Jrerly7yLI=;
        b=VsU8bwlHh5NdsB4hvvR2fqQrKffMevBGqEVleXFzUYl3sH661YCjADqNrMcdhSyXmR
         80fq03VeozkqrT6GdonMBQpeO2K3bQk3M8PndKQv8L8QoZEiAXoijjXzs9at7xzwLJGu
         llztnIqkKxxZD/SwrREYDrVHOXsbjigu7XNDPjrbHhGn2WNTXDir28Qp9IjDk3CT9Np+
         3Lh+njf2w7DNfRUvum6+onpyyy7VM6Ih9ro/zGSCTu00pDLVmYqV6tmSDE4dUsit0yCd
         CVW0Nr1E1GGyQE5bbcoli1oSZU6itCWaoimMbD398ofvdg983U+lYzEEdHB3hDRzKTG+
         6raA==
X-Received: by 10.229.175.202 with SMTP id bb10mr4199319qcb.136.1370889216899;
 Mon, 10 Jun 2013 11:33:36 -0700 (PDT)
Received: by 10.49.52.137 with HTTP; Mon, 10 Jun 2013 11:33:16 -0700 (PDT)
In-Reply-To: <CANiSa6iTJuXnKTL50GOv7b=pLLUqA4vc-EsSLi3trh4Ehh3xTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227346>

On Mon, Jun 10, 2013 at 2:11 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Mon, Jun 10, 2013 at 9:58 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Jun 10, 2013 at 4:05 AM, Stefano Lattarini
>> <stefano.lattarini@gmail.com> wrote:
>>
>>>> You need two sides to have an argument.
>>
>>> I disagree.  Unless you mean than, whenever a part behaves in a
>>> hostile and aggressive way, the other part should just silently
>>> knuckle under.
>>
>> You are wrong. If a bum in the street starts talking about you about
>> why you are going to hell, and you reply to him and argue. Who has the
>> fault of starting an argument?
>
> I'm not sure I follow the analogy. Are you the bum or the passer-by?

http://xkcd.com/386/

Someone is wrong on the Internet!

Let it be.


m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
