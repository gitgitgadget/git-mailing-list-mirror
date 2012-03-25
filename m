From: elton sky <eltonsky9404@gmail.com>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Mon, 26 Mar 2012 09:35:01 +1100
Message-ID: <CAKTdtZksoO47rbni84jTiycmpqfmk10hv-iwEoZn3PFejFtQLA@mail.gmail.com>
References: <201203241711.30270.jnareb@gmail.com>
	<CALUzUxrZibRf5ERgM7QAxsP4QDNZj-RvuLLh0bW5mqMWQnDcig@mail.gmail.com>
	<4F6F3286.5040803@andrewalker.net>
	<201203251745.48858.jnareb@gmail.com>
	<4F6F526E.6050200@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: =?ISO-8859-1?Q?Andr=E9_Walker?= <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 00:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBw1n-0007qH-1g
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 00:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279Ab2CYWfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Mar 2012 18:35:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54572 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab2CYWfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2012 18:35:03 -0400
Received: by vcqp1 with SMTP id p1so3958134vcq.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VF3OaB9rPSLEt0T1Fc9S/OFWDkjhgjWj+1FECDtmy4M=;
        b=GxrJ/oVJjfclr+RxXDg0BF1ySXZ9XsMg9BA6gwoLO4acnfxXqbuj0hQDWTaJiFsE5z
         QZfLVINQwx0eMpaUJ4ScCwE0OtKkryHPxpZ9sHm0+ztV3YHkz5YEnFyI3tNjGYnCtOgZ
         xnwts5FWW2g1sNLn4a8BRfPw5LlSRnMQkN762O5O9Xig0dFrdhfbk2xFoztaPX2q1Ndq
         47aVWmypRialDte6wlITK2Oy0L8FAs9vJrhTp0XmI+6XycFCjyt9ikMzdGM15bP70+FJ
         MlT1NaziDexu7KJT+vErShcZIf6M948Zyn/rf2uBV1BgDLQvWVtyfT+DSz1/KjeuP2Yy
         Nbkw==
Received: by 10.52.22.166 with SMTP id e6mr7647447vdf.5.1332714901459; Sun, 25
 Mar 2012 15:35:01 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Sun, 25 Mar 2012 15:35:01 -0700 (PDT)
In-Reply-To: <4F6F526E.6050200@andrewalker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193886>

On Mon, Mar 26, 2012 at 4:14 AM, Andr=E9 Walker <andre@andrewalker.net>=
 wrote:
> On 03/25/2012 12:45 PM, Jakub Narebski wrote:
>>
>> I don't know the details of how decision is made on how many project
>> slots a GSoC organization will get, but in earlier GSoC (see Git Wik=
i)
>> we get 2 to 6 projects (IIRC).
>>
>> One limitation is number of possible mentors.
>
> Well... I hope Git gets more slots this year! :) Do you know whether =
there
> were so many proposals in previous GSoC's?
>
>
>> BTW. according to Google Summer of Code FAQ there can be more than o=
ne
>> student working on the same project. =A0Though IIRC it never happene=
d in
>> history of Git participation in GSoC, isn't it?
>
> That's awesome! I didn't know about that.

This is a good news. If this can actually happen there is no problem
for student "clustering" on certain proposals. I think this is good
for git. Take the  "Designing a faster index format" as an example,
students comes with different formats. Perhaps they may work better in
various cases. This gives more options to git. And more chance for
students to get involved for sure.

Regards,
Elton

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
