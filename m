From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Bad attitudes and problems in the Git community (was: Re: [PATCH
 2/2] Move sequencer to builtin)
Date: Mon, 10 Jun 2013 11:58:10 -0500
Message-ID: <CAMP44s3LXrp5_6eHvsFp-4oyoX5FQY0TF_w+ZfQXNS89YzaXaQ@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130609181002.GC810@sigill.intra.peff.net>
	<CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
	<CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
	<51B4F6CA.8020807@alum.mit.edu>
	<51B51256.5060602@gmail.com>
	<CAMP44s3qn2vTQ1oDnAe6m5AzZ_tAK0fe1=-nN=_=fv7TXGnMbw@mail.gmail.com>
	<51B596E9.9080307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:58:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5Q8-0001EA-G8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab3FJQ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:58:12 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59299 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab3FJQ6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:58:12 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so2330994lbi.6
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wPejmEch/zaQ7pxbv1dIRVN2+3hwYwPMFLaEX1TWMyI=;
        b=w1tLok8q81ztqbu3chT9tDGqPOjbcssGAHkhiPp+gxaIKNggF589tt4e+bq7mTEHaZ
         e2sOeHaiUoNrosH/zaqvxS/3f1yReyxEkkhsLO7FW8b+wZwKRbkp5GZwv3cFodF370hR
         vyS1Xbvja+QqsJtz0CKtliJ2s4OX30fkoZSOeRozKv3oyOdGr2LiX3UB2AKuxLO2xrsk
         sFD+po/rYh6yy1Jnlv96UwC9gDwcPXufpZs9G/dNa7wwPS07RxFw8q5NRZZS7dwarhF+
         aQ71usHU7FDKgcjT8YsztdJ6LK4qBesofXKX8EdoXmu0YZaXuJeSS5U/Y1Q1FQh2+1F+
         /6eg==
X-Received: by 10.112.156.5 with SMTP id wa5mr6914624lbb.63.1370883490493;
 Mon, 10 Jun 2013 09:58:10 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 09:58:10 -0700 (PDT)
In-Reply-To: <51B596E9.9080307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227323>

On Mon, Jun 10, 2013 at 4:05 AM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:

>> You need two sides to have an argument.

> I disagree.  Unless you mean than, whenever a part behaves in a
> hostile and aggressive way, the other part should just silently
> knuckle under.

You are wrong. If a bum in the street starts talking about you about
why you are going to hell, and you reply to him and argue. Who has the
fault of starting an argument?

Both. Maybe you have even more blame.

-- 
Felipe Contreras
