From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH/RFC] perl: bump the required Perl version to 5.8 from 5.6.[21]
Date: Sun, 26 Sep 2010 12:22:17 +0200
Message-ID: <AANLkTimN++eDHhcnyYh=RLOLqgHe4x+fKKpzspFKh3LU@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<1285358453-19292-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 12:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzoNE-0006Df-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 12:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab0IZKWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 06:22:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57628 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab0IZKWS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 06:22:18 -0400
Received: by qwh6 with SMTP id 6so2724796qwh.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=EjI6vtQ/CFveb1aYVKjfHS/nR+Q72YW76T36vruBvW4=;
        b=ZTSdr3WLpDQEfRWo1V5lOscIa2sgVvn9IG7U7YU9FZhnErDjKpjsTynr1TfeohDYd+
         z6kNAvfcbVDsgrHLlE8YGjjj8GzZeQa5FMh2aQV3p4myZ7pOleStlEWpl7pZWGZ/K8OZ
         kTF9HJGvBo7T9IVW4yRMaYd+V7qSW5Z6pKIYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=YhhgQsAqbqCSbAy5/Flgd4C1d5Heh2SI7Ji3UBax52XZqnLZaxj1++Tc7j9jcgzXD3
         V3+2FzD7FiPH9uK1WDsnVXuI3mlt1QvLeKzj4t9C+i/d+234PGCdJf2pIFXdkhHwvbsG
         tw/VT3i1tVdKR+Y0Ql47UFMaxpdsEWv8lMBwg=
Received: by 10.224.98.81 with SMTP id p17mr4173554qan.290.1285496537561; Sun,
 26 Sep 2010 03:22:17 -0700 (PDT)
Received: by 10.229.66.157 with HTTP; Sun, 26 Sep 2010 03:22:17 -0700 (PDT)
In-Reply-To: <1285358453-19292-1-git-send-email-avarab@gmail.com>
X-Google-Sender-Auth: LSCWKa8TalM7D3QWvqFjlLn7y9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157218>

On Fri, Sep 24, 2010 at 22:00, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gm=
ail.com> wrote:

>
> A follow-up to the discussion in "Let's bump the minimum Perl version
> to 5.8". I took the liberty of adding Tor and Randal's Acked-by to th=
e
> patch based on their comments in the thread. Which is why this is an
> RFC, if they're OK with it it can be applied.

This is OK with me.

-Tor
