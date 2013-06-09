From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:16:37 -0500
Message-ID: <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkAd-0004TY-Qe
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab3FISQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:16:43 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:39185 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3FISQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:16:39 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so5536850lbh.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F1qBfsxXRAlEMy2B+l8oBtUNqEXLapv2B3YE1w7X09c=;
        b=AnhV9YfKCMHGeOUFut7XMPlN2mIs2oGAjM2beHT2Hj4LHzEPOfYDE8tvBoPrYajC7Q
         rmsO+F4VdD3IKxGVpPdGkP5Mb4vCTnIXYcK3PlOb0PU5bzFy+8gF8WD6takefSPwBWs3
         741RV8ZG/NrviEMSHZnojLCmFWstD05jOxHf6Wil7m4yuxFNRCzF7BOh6mbkBSOQRJd/
         /ZldVGPbObJ9KJE1K1wmWHthPx64trwwSisYBYBnzE+wxSQGSBFEgOIpBP7d8e0zoK+b
         YFqr3zZ/H2Ck4+kACfV3X3wJjiueR4TYH2dH3gYmoD3IP8YOo/2DkwKY0L5sjYNJJdJT
         87tQ==
X-Received: by 10.112.156.5 with SMTP id wa5mr4960717lbb.63.1370801797983;
 Sun, 09 Jun 2013 11:16:37 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:16:37 -0700 (PDT)
In-Reply-To: <20130609181002.GC810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227082>

On Sun, Jun 9, 2013 at 1:10 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 09, 2013 at 01:01:30PM -0500, Felipe Contreras wrote:

>> > I do not have an interest in cataloguing past conflicts I and others
>> > have had with you; the list archive has done so.
>>
>> No. There is no such catalog. You made a claim, it's not backed by
>> evidence, merely by your subjective experience. And memory is a pretty
>> bad indicator of reality.
>
> I think this thread is an excellent example all by itself.

It's an excellent example of your personal issues clouding your judgement.

The topic was this (which you just snipped):

> Go back to my 261 commits, show me one that is "unmindful of technical details".

And you say this thread is an excellent example of your point that I'm
unmindful of technical details?

It's not. There are no technical details I was unmindful of in this thread.

Once more, you have no evidence of that claim. Only subjective
personal experience.

-- 
Felipe Contreras
