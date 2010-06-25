From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v5 1/5] test-lib: Adjust output to be valid TAP format
Date: Fri, 25 Jun 2010 21:39:49 +0000
Message-ID: <AANLkTikLoLqqn6JQ8CHtmL_L9aXfzUH58ECW0RREERIk@mail.gmail.com>
References: <AANLkTinVp6kivNzbdUj-7EXjKrolBqvtsNROo-dCSydn@mail.gmail.com>
	<1277416332-12072-1-git-send-email-avarab@gmail.com>
	<7v6317koy2.fsf@alter.siamese.dyndns.org>
	<AANLkTilYoGtTIr9lIQD4sx4PRjlWYjIwSDMquREzv6eq@mail.gmail.com>
	<7v6316kd6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:40:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGcu-000430-61
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0FYVjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 17:39:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33189 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0FYVjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 17:39:51 -0400
Received: by iwn41 with SMTP id 41so2419749iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cS0zXy49zb97dKPbj19flR3lJSV9DlIviLW/vD00/pA=;
        b=eKA5EaQmM1cUaPG9Q1O4fPUFjmBeHKBqZ9FD4JFfnfwNTEG+Ukz50U7hU5XnJc65NU
         TAZDOWM+tDCxH/oG6xum9MbjN7qszWc++k4xqvaIne65HfZrnBoTunWzUTMI7/gN+TGW
         b+jsMrxZuHHL1n27JC3x45jlZmOjpgmWRY0OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EvnQkQk/ObUsw68QNIZ//2Xk2WDRgKgLLN76KaTPfmS+wXRY8pgFDm8r6jANcC2PPy
         jv9t50p+YRA39r3EavK+PYBkzqILRQ7ZlnMctOK/quNIeEY5FfgiI5wWqzpJsz7ZCh/4
         gyDUOmJlsPwHNzqgBRpxNi0uimBR63geb8H3I=
Received: by 10.231.185.6 with SMTP id cm6mr1337841ibb.72.1277501989557; Fri, 
	25 Jun 2010 14:39:49 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 25 Jun 2010 14:39:49 -0700 (PDT)
In-Reply-To: <7v6316kd6g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149711>

On Fri, Jun 25, 2010 at 21:36, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> I'll write those docs, but I probably won't have time in the next fe=
w
>> days so I'll submit a patch for that it separately if that's OK.
>
> Oh, absolutely. =C2=A0I meant to say that v4/v5 round already has a g=
ood
> documentation for test users/readers; a follow-up patch to help test
> writers would make the series more complete.

Sweet, yeah I'll make the t/README more awesomer later, good to hear
that v4/v5 is good enough.

Thanks!
