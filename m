From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 12:35:32 +0530
Message-ID: <CALkWK0mT7srC5+Jgk6G5gze+WwVZ-9rJJfCO5OAScaT+YLfZGA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie> <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 09:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgX2d-0006qP-61
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 09:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab1GLHFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 03:05:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58722 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1GLHFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 03:05:53 -0400
Received: by wyg8 with SMTP id 8so3046357wyg.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k+v490RVhghLeQhibQWxv1Kl5oKg0HHjQ7bWGBpOGWg=;
        b=YaPB9FaUppZJYx0wp5A4K/OaK/Uus/EVAdH11EM+DM6FphXvQi8Jk7nJI+USqB/fuo
         TjaCu4KYnb587ii0D4M50xic948aVawP2ol9QRzvcMRb96uZo6KArECKNAV8TBuU3XSA
         NXvnFKU5sGghB7iTl3Ne5QgKVoS65tFeT0ubw=
Received: by 10.216.187.65 with SMTP id x43mr4905966wem.62.1310454352171; Tue,
 12 Jul 2011 00:05:52 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Tue, 12 Jul 2011 00:05:32 -0700 (PDT)
In-Reply-To: <CALkWK0msdBdXX4oMkd+WAMR8PXTRT3ivjMrf3ZAMfBrsLoM=dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176935>

Hi again,

Ramkumar Ramachandra writes:
> Jonathan Nieder writes:
>> =C2=A0- what changed since last time, for each patch? =C2=A0(For the=
 future, the
>> =C2=A0 space under the "---" is generally a good place to put that
>> =C2=A0 information.)
>
> Will comment a little more on this in the morning. =C2=A0The main foc=
us of
> this series is to showcase the new option parser, and show how it fit=
s
> into the rest of the series.

Here's the full change manifest (from memory; might have missed a few):
Patch 1: Exposed advise
Patch 2: No changes.
Patch 3: No changes.
Patch 4: No changes.
Patch 5: No changes.
Patch 6: No changes (forgot to update commit message)
Patch 7: No changes.
Patch 8: No changes.
Patch 9: Rewrote commit message
Patch 10: New!
Patch 11: Updated commit message, rebased on 10.
Patch 12: New!
Patch 13: process_continuation =3D> process_subcommand
Patch 14: New!
Patch 15: New!
Patch 16: Near complete rewrite (subcommand, documentation, tests)
Patch 17: Complete rewrite.

Thanks.

-- Ram
