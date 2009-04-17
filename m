From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH 1/3] Documentation: fix typos / spelling mistakes
Date: Fri, 17 Apr 2009 20:32:34 +0100
Message-ID: <e2b179460904171232s52932dfcm1e3e310b346d3275@mail.gmail.com>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk>
	 <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
	 <200904172048.55528.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: markus.heidelberg@web.de,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lutpa-0003OB-SY
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 21:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbZDQTci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZDQTcg
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 15:32:36 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:49510 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZDQTcg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 15:32:36 -0400
Received: by gxk4 with SMTP id 4so2298760gxk.13
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aYCfbY/T32jvZCIl6T+dIceM/j35e9Y08IdCjJnJ3/w=;
        b=G84lt6stZ//1v4chCTiDmeMuxDaVuSJV8W85S20SbiF5iLv8Ij3hS96eiiSS/5patF
         GwTk/EnaJ1wjsTEqb/QxhNQkrkpyKK/sRXTimvKonNHtVaOytiPdGS4pvxpMgDn0Y0vN
         +GJWui9z6eeYkprwGPUY0UOlTSqDsu8n26B6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xDD4h7cJtJtNwOmxS54t5vC/AWLH/xiuhAi7JNDHaegP7ELae5dns55KrBKUPHZdGe
         xrfOiQH/RaDTTq08iSD4xm4gWiW+x2F29XDd67eR8QFd/T3KmM3w52PkOHXzRQxgxH/b
         1I3Fri8Np+9cgouJ57uQ9EwYt8Xpj5/+i14hw=
Received: by 10.150.154.6 with SMTP id b6mr662120ybe.236.1239996754596; Fri, 
	17 Apr 2009 12:32:34 -0700 (PDT)
In-Reply-To: <200904172048.55528.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116780>

2009/4/17 Markus Heidelberg <markus.heidelberg@web.de>:
> Mike Ralphson, 17.04.2009:
>> diff --git a/gitweb/README b/gitweb/README
>> - =C2=A0 'utf-8'. Value mist be valid encodig; see Encoding::Support=
ed(3pm) man
>> + =C2=A0 'utf-8'. Value mist be valid encoding; see Encoding::Suppor=
ted(3pm) man
>
> I guess this should be "must" instead of "mist". Of course the spell
> checker couldn't find it, but while we are in this line...

Annoyingly, I *did* find it and fix that in the proofreading stage the
last time I ran my check, but I foolishly decided to just bin my work
in progress and reset to HEAD and merge in the latest master. Then I
forgot that change in my hurry to get the patches out before I was
thrown out of the building by the cleaners. And that's a very painful
way to be thrown out 8-)

Thank you both for spotting it.

Mike
