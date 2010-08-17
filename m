From: Vicent Marti <tanoku@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Tue, 17 Aug 2010 13:33:27 +0200
Message-ID: <AANLkTin_Ne+wYBXSpwOm5KNM+M3Zet0N2zPVEO+-pcjL@mail.gmail.com>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com> <AANLkTikUKS7jjXyzLY0h50jg1gdDsKKWM3ZkPQcbgAJ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 13:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlKQX-0002wD-7J
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 13:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab0HQLdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 07:33:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49386 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab0HQLdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 07:33:53 -0400
Received: by qwh6 with SMTP id 6so5939192qwh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=QsCEV68483Ee+QsgOX1eaDnSXLJXALb4IZpsGXJw/EU=;
        b=EPGiEzhtssNPCs9CoPN2tv2HFUbY2hqctbbpspATEF/4+2dYthHJPXOuolfRQKGPk4
         lhlxsJL3BAUpcgoZma72Wp70zazc3jJ4diV8j/DNgpLZJfgNTB+vEI/t+U1L9AHTgAK2
         dTBDN7rv/0BBdydrjf5bwQluJbOaKkRvXFHkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EaFxk1D6gzqAOaeJQKfz7HtyyGa/QuFg4qbMkoUpLBQw65tR5gHLWQZ6JNgzOBmgmI
         CtjcLZ2d9/HJtYmjTlkAzGJLD4p18bY97tbdnoPTRYGFzTyJ33asBovbxk60owLn5U7s
         p3j5zgiqK8CX53mGJ21dNoavIUPjXNdC3ieCo=
Received: by 10.229.52.20 with SMTP id f20mr226445qcg.243.1282044827181; Tue,
 17 Aug 2010 04:33:47 -0700 (PDT)
Received: by 10.229.247.138 with HTTP; Tue, 17 Aug 2010 04:33:27 -0700 (PDT)
In-Reply-To: <AANLkTikUKS7jjXyzLY0h50jg1gdDsKKWM3ZkPQcbgAJ7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153745>

On Tue, Aug 17, 2010 at 3:53 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 17, 2010 at 3:46 AM, Vicent Marti <tanoku@gmail.com> wrote:
>> the Summer of Code has just reached its end and I'd like to offer some
>> closure; neither me nor my mentors have been too active on the mailing
>> list -- to be fair, there was too much work to be done on the library
>> before it could be considered of general interest. We've been focusing
>> on that.
>
> IIRC, Scott Chacon from github is your mentor?

Yes, he is.

>
> I wonder if libgit2 is being used at github (either directly or via
> ruby bindings) - not only will it help through real-world testing, it
> will also help to boost "street-cred".

The library is not ready for production use; however, as far as I know
they are interested on eventually using it -- when it's ready. I do
agree, that would mean a massive boost to its credentials and
development.

Cheers,
Vicent Marti
