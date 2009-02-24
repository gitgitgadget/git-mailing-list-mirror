From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 00/23] builtin-remote improvments
Date: Tue, 24 Feb 2009 12:36:56 -0500
Message-ID: <76718490902240936o723513eem2721cb1d1af1c448@mail.gmail.com>
References: <cover.1235461736.git.jaysoffian@gmail.com>
	 <1235472816-52420-1-git-send-email-jaysoffian@gmail.com>
	 <49A3D3A0.4060205@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1Eh-0005pG-Vw
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbZBXRg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbZBXRg7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:36:59 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:13165 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbZBXRg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:36:58 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2568809rvb.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 09:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=37aiL1Mutyb5o7mh787DuIa9Pb+mbSAotm9aJtxyb5A=;
        b=SgyuPtfPmL8dpeF0JbQwROCWRaJkltnue3Qcb5OG7/xZRBCw2UQhzQ3uMpMxexJ/iw
         URwKDFvwxKH/P0M57CWMx0VRJlUCyTvKYw4IQWxAi8j6kr7aXsr6zOTIhaDDvGgOVft+
         T13RdJHY43qOsrF3lt5nLPi8QkwqOX/NhIiu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cSV4zdd/1VoHWaZKJU10Ive11Ze0ZuRH5ZKDH8/Ad1GrD4XUzlVkv7egj22F0NlBTK
         DHOT0CrBVhljNmnv6S8p6arBWs51xCWXYk27Ga0j0ZDZxuoP3AnGsV2AesOwrWPJ7ARQ
         XlQf9vza4+r6KyUYz0vac2rPhQsdN1iHJ7SsA=
Received: by 10.141.29.11 with SMTP id g11mr2713670rvj.17.1235497016681; Tue, 
	24 Feb 2009 09:36:56 -0800 (PST)
In-Reply-To: <49A3D3A0.4060205@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111320>

On Tue, Feb 24, 2009 at 6:01 AM, Marius Storm-Olsen
<marius@trolltech.com> wrote:
>> All of this is my way of saying ignore what I've emailed tonight
>> till I can clean it up a bit more.
>>
>> I apologize to the list for the spam.
>>
>> When I have the series really ready, would you prefer I setup a
>> repo for you to pull from? I'm loath to spam the list with another
>> 24 messages.
>
> It would at least be great if you could include --thread in your options to
> git format-patch, so your patches are threaded underneath your cover letter
> ;-)

I did, but I had run format-patch twice because I changed a patch.
Unfortunately I kept the cover-letter from the first run but forgot to
update its message-id. So all the patches reply to a non-existent
message.

:-(

j.
