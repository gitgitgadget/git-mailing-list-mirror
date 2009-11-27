From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 07:29:26 +0100
Message-ID: <36ca99e90911262229o563ce504v6e3d6be15f4fa81f@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <20091118142320.GA1220@coredump.intra.peff.net>
	 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
	 <36ca99e90911260405y42a9a07cx419d2973ec673039@mail.gmail.com>
	 <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuKw-0005up-Fo
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbZK0G3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 01:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZK0G3V
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:29:21 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:59088 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbZK0G3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 01:29:20 -0500
Received: by fxm5 with SMTP id 5so1305396fxm.28
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 22:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kOjxVeuLK38U0Lo2pR6qpOP/Pc0kMghbgLCNTe32Yx4=;
        b=rw+dKDAAvAR7bpeBSUCE5W6+3aUeSKcGocip6CX6J+VjCnyvKGCHaT+7tKUFO6fIoP
         00KtJEvsGuJtd0cCK5IvEpZFYpcQcrLr8fqL7ICwEKbWaqDCwJglb+n0H0TcWnJvi2aH
         TnumzqREzqPQ9PtaI1LNfzzdQhSw8AG97s4Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HYh2/01Igmejn9zArBBqHqQaKD0Pajue/6CUZuFoYFaTw3t4nELMjNIJ2KJU2/7t5e
         xIQtAN7N33Zt2kM2hi5q8xiL75Fn7aKC2qddw0BDl5KL0/RweEgHr8IEhxJ61ctSaXXN
         kmd2iTxq7tvpK8FHlJOY0Do672j+2B/5NKPFM=
Received: by 10.223.144.81 with SMTP id y17mr99494fau.68.1259303366041; Thu, 
	26 Nov 2009 22:29:26 -0800 (PST)
In-Reply-To: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133860>

On Fri, Nov 27, 2009 at 03:38, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> may I kindly remind you of this patch.
>
> Yes you may ;-) =C2=A0A more effective would have been a resend but i=
t is
> always appreciated.
>
>> ... If it is only the nen-existing
>> consensus of the default color, than please use the die.
>
> If you are having me go find the mail and apply I would probably use
> "plain" as I suggested.
So I resend with plain as default. And therefore saved one resend ;-)

Bert
>
