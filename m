From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Tue, 11 Aug 2009 23:24:00 +0200
Message-ID: <20090811232400.24824426@eleanor>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
	<20090811224717.785dcd27@eleanor>
	<fabb9a1e0908111355m1a15d81cs7f33e1bbc5e1701b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:29:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayuA-0004Xw-Dw
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbZHKV3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZHKV3F
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:29:05 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:45527 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbZHKV3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 17:29:04 -0400
Received: by ewy10 with SMTP id 10so4119796ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=c2nX3TYAvcVcXw88P1ZxzAMqnmgKCPakSTDP9RyFCRU=;
        b=i7ubkJsY985mwduOUMfOnOKQz7ZNQLEjn8WRlTHGt4SHEC7n8ZHaFGFrvmk+pln70K
         Bqyc23oPRwJpIQPD4veFwW1KGrn7kSXvSS30Il/LCYg5NSA+MKtJic3hDg0XMgjLlTS1
         2/LKvePJZbIZq7mvc+Q3TNfEo4X7pblzibIxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=v26dbKHG58FRYGmbl3U5Bh9Sq5oEE1XyfEHaJJsohSWEyS5zkdwQ3r9o5uMNLTaL19
         3ySO2kJv15llq+AwFE0+qZ4Ccz9FreiGxt9vMFiczfr1L5UURs9WZKRg0+ZErMUbPJ8O
         GtfjIrpTlTcOGAAtq3mlYFbSlfb6Kj/0GxvrY=
Received: by 10.211.195.15 with SMTP id x15mr1511148ebp.9.1250026143948;
        Tue, 11 Aug 2009 14:29:03 -0700 (PDT)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 5sm956168eyh.36.2009.08.11.14.29.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 14:29:03 -0700 (PDT)
In-Reply-To: <fabb9a1e0908111355m1a15d81cs7f33e1bbc5e1701b@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125602>

Huuu! Sorry!
I read your mail too fast.
If you manage to save the interresting mails localy in the mailbox
format (claws mail and thunderbird can do that), you can
then use 'git am' to apply the patches (an example:
http://www.kernel.org/pub/software/scm/git/docs/everyday.html#Integrato=
r).

Best regards

Emmanuel Trillaud

Le Tue, 11 Aug 2009 13:55:38 -0700,
Sverre Rabbelier <srabbelier@gmail.com> a =C3=A9crit :

> Heya,
>=20
> On Tue, Aug 11, 2009 at 13:47, Emmanuel Trillaud<etrillaud@gmail.com>
> wrote:
> > To quote Documentation/SubmittingPatches:
>=20
> Not relevant, these instructions are for the other way around; that
> is, sending your patches _to_ the ML, rather than getting patches
> _from_ the ML.
>=20
