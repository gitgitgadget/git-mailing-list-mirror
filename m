From: demerphq <demerphq@gmail.com>
Subject: Re: rsync deprecated?
Date: Sat, 20 Dec 2008 18:08:29 +0100
Message-ID: <9b18b3110812200908o5f162218hceee0e82a3265993@mail.gmail.com>
References: <200812180041.10312.markus.heidelberg@web.de>
	 <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
	 <20081220081511.GA28212@glandium.org>
	 <9b18b3110812200212o46edf51eoaff43ec1b8fc3913@mail.gmail.com>
	 <20081220170219.GS21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 18:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE5Kq-0006uJ-MJ
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbYLTRIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYLTRIb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 12:08:31 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:19118 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYLTRIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 12:08:30 -0500
Received: by qw-out-2122.google.com with SMTP id 3so571902qwe.37
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9R/Kbv0QVn6h5UEr3ayGGsMADxUmRW5qpeg4Wbd/tYw=;
        b=RIwtCSJ0FHfXBV7QU/p9wjZFUIxtRfsLdbgFUohmBrT2XoPAz54LGpUWl5MpGYwcgH
         ctqh1IoUwxj95ewnBVFv1oHSos1DSosC8CtLN/Nl+xWpz05l54PNORubWfk5/aADFEsk
         POlWLZvVdbY8FDQrWMdILgJBq/GG+Cc7sUpoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EPB1kqqPPKmXJutu1GPNCgiDvl2hu8w3ppyBVZrdTYHyj6iqKw7Hh1I2FH6BwT+0cH
         8d85R8PWtodmmoq8YLXKR4kGjSZNt0f2gwpQ6nHR5ruAtNTZeFr2BxhgnswZdpxDaJ0H
         2847lEUPdAGNVDXtJHjCm24CHIMf2HH22pOXo=
Received: by 10.214.115.12 with SMTP id n12mr5131003qac.52.1229792909520;
        Sat, 20 Dec 2008 09:08:29 -0800 (PST)
Received: by 10.214.241.11 with HTTP; Sat, 20 Dec 2008 09:08:29 -0800 (PST)
In-Reply-To: <20081220170219.GS21154@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103651>

2008/12/20 Miklos Vajna <vmiklos@frugalware.org>:
> On Sat, Dec 20, 2008 at 11:12:11AM +0100, demerphq <demerphq@gmail.com> wrote:
>> Is there a bug tracking tool that git uses? I asked on #git on irc and
>> they said to just mail the list, but ive not seen any response to my
>> mail at all and the timing of Junios comment makes me wonder if my
>> report was seen by list regulars at all.
>
> You did the right thing, just nobody who read your mail had enough
> time/knowledge/motivation to reply something constructive for you.
>
> Similar to patches, I think if you get no answer in 3 days, you can try
> to reply to your own mail, bringing the topic up again.

Ah, yes. Being new on this list it is all too easy to suffer from
Warnock Dilemma.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
