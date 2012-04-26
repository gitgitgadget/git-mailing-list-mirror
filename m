From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 17:12:59 -0500
Message-ID: <20120426221259.GA16192@burratino>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
 <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino>
 <20120426210251.GA31589@sigill.intra.peff.net>
 <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"David E. Wheeler" <david@justatheory.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNWw7-0001L0-Ff
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab2DZWNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 18:13:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39393 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab2DZWNJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 18:13:09 -0400
Received: by iadi9 with SMTP id i9so125013iad.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PDpPaFCOGQ8oy0vo74vCcvBiTK4CC8QD6KA0XsKCwqI=;
        b=0CMArU+1IDUGEZmjU6wOtgx5eSe46cT6tD1HyoYawQY9NWj0DUSnKbQUhhArAXhU/z
         KXGgIZocqlSVzX6QwfgiAB0bG4QK+mAjep3WA2K4wmk3EAqjt1UKkp4FGY12P28ULqT4
         iTd3r2YHmGzhLKb7i8iBu26iiBJfKjKCjAgM4Ywo+K7gDS2pv194Lr12BWNXmixiIUB6
         Ejd7MVMk+ljIet59FLaCJVlPyc3JGPKucgW5AF27gLL9mj8NADJG4etkGdiUuBqNt64t
         e9F+U3c5vRR2apWzMK33aQ6monzNISBxV5TyokPMBexuhtQpos3i+xcVdYRERH6UDGtW
         yPVA==
Received: by 10.50.187.137 with SMTP id fs9mr20752648igc.50.1335478388482;
        Thu, 26 Apr 2012 15:13:08 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us6sm24534igc.9.2012.04.26.15.13.07
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 15:13:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196420>

Scott Chacon wrote:
> On Thu, Apr 26, 2012 at 2:02 PM, Jeff King <peff@peff.net> wrote:

>>> Do you know of a public webpage we can count on to continue to serv=
e
>>> the docs? =C2=A0I agree that that would be even better.
>>
>> I think http://git-scm.com/ would be the ideal place. My understandi=
ng
>> is that the re-work of the site is nearing completion. Scott, ETA?
[...]
> If you want to preview what it's going to look like and the URL
> structure, you can check out the current working version here:
>
> http://git-scm.herokuapp.com/docs/git-fetch

Is it intended to include documents such as "technical/api-credentials"=
?
I ask because David was looking for some permanent place for the
references section of pages like gitcredentials(7) to link to.

Curious,
Jonathan
