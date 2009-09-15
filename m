From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 15:11:57 +0100
Message-ID: <26ae428a0909150711h1f7bc593j541d5eb7201a7e45@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <20090915130640.GC31846@atjola.homenet>
	 <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 16:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYlZ-0007Xs-3N
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 16:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbZIOOMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbZIOOME
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 10:12:04 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55635 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZIOOMB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 10:12:01 -0400
Received: by ewy2 with SMTP id 2so500914ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1XctLqVzrYG491mNnxS8Ez/vEALd2Z6cJsk9BeYeaKo=;
        b=CrS/nYQpJ1UdT9iicTN2yhaTDJFwJuwhgwBBPFx3u3AOOKXoRk8rnCSfAKBeox5nhi
         fX3yz2B8z4mbUCSmKUgfCicSe0XV4BRQw/Due7/HA26MJJnXOPCHZ/o6/DUDpPxSvQKm
         YbZ9jDuniazClQm/YTOUYKEwLa7K36BQ21EGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Ylt41skRBdAuA2iSxulLV7/lJWVYQ2J7iiJNUEiDOIXteRjLMk9N2QJaqj/wZ4a+yi
         PXwml7roBK920zJN1AAwpPtKQOjRTEOANnOWGqUTuKeaAbFPTwNM8FvDyxZFxaVFIA0P
         uuIWX6TY/4CwO5n4TpjcZlw1CRi/XW30Am2E4=
Received: by 10.216.12.67 with SMTP id 45mr1094107wey.218.1253023917837; Tue, 
	15 Sep 2009 07:11:57 -0700 (PDT)
In-Reply-To: <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
X-Google-Sender-Auth: 0951feda2a264cb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128566>

2009/9/15 Martin Langhoff <martin.langhoff@gmail.com>:
> 2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> [Please stop top-posting...]
>
> Not everyone is deep in mailing-list lore :-) -- we can help anyway.
>
> Howard, I see you're wondering about it: http://www.idallen.com/toppo=
sting.html
>
>> Just don't use patch(1), there's no sane reason to do that, you're
>> sacrificing all of what git can offer there.
>
> Oh, yes there is, specially for newcomers used to patch, and how it
> handles conflicts.
>
> In this case, I happen to know that Howard is a refugee from CVS land
> (the moodle project in this case), and he is familiar with the output
> of patch if things go wrong.
>
> It's not what I'd recommend to someone that is deep in git-land. But
> even myself (with a bit of code in git) sometimes use patch when
> git-apply tries to be too clever and I just want a damn .rej file to
> review and edit with emacs.
>
> cheers,
>
>
> m
> --
> =A0martin.langhoff@gmail.com
> =A0martin@laptop.org -- School Server Architect
> =A0- ask interesting questions
> =A0- don't get distracted with shiny stuff =A0- working code first
> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>

=2E..and I still don't understand cvs either  :-)

(NB. I have put my reply at the bottom where nobody will see it - this
is why forums are better than mailing lists.... >ducks<)
