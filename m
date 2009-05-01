From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] user-manual: use SHA-1 instead of SHA1 or sha1
Date: Fri, 1 May 2009 11:26:03 +0300
Message-ID: <94a0d4530905010126w524fd014t9a0752297b6d48fa@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <7v3acm9p1v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 10:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzo59-00057Z-1p
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZEAI0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 04:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbZEAI0H
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:26:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47950 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZEAI0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 04:26:04 -0400
Received: by fxm2 with SMTP id 2so2225959fxm.37
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ijbv4uI8OCNs+9Mh++P4+hkJn0haTK9Rc9OXJ2yLtg=;
        b=B4Lhtw5wJE0f/O1jtsgCggxqJohe+kkNZVz2kN6odRNbrHhw1HedtBd+/NozEQGUNW
         YCXgyGPgFY2zhqDHf4Cll+LLqE1uKTIuDxm+32sSBovo7yf6PsnV0/P+AW2Y2HrgC0V8
         aXRx79d+obNImjBVLqkMxcXq4+5igOK9NYRHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Erz3mAbFUVOob5ZOkjFF74y7E4vhe8Ime+gR8wpTUQgpQKGWhSOPVTHUhnoepstfxu
         fczNnbrZneG5kZTkttbonC4KnAWJyq6ekn96OTrSP3DYKsFBFzbgY0nbHCyV9iz3ueq/
         65Bxf9hDb1srgdEYIaqzXnJnDvG0bsKlFS0+4=
Received: by 10.86.49.13 with SMTP id w13mr2677664fgw.38.1241166363661; Fri, 
	01 May 2009 01:26:03 -0700 (PDT)
In-Reply-To: <7v3acm9p1v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118059>

On Mon, Apr 6, 2009 at 11:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thanks.
>
> This also seems to depend on the missing 3/7 but I've managed. =C2=A0=
I retitled
> it to "user-manual: the name of the hash function is SHA-1, not sha1"=
=2E

You missed one in the Trust section. I'll send a patch.

--=20
=46elipe Contreras
