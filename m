From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2010, #02; Tue, 26)
Date: Wed, 27 Oct 2010 21:57:38 +0200
Message-ID: <AANLkTikmGirtcerFL8+eXApyzOmqEifBWVY8A7TrzAGi@mail.gmail.com>
References: <7v62woduyp.fsf@alter.siamese.dyndns.org> <AANLkTimPfnH0n4xG0bxyDKT5j2aQEXKKZtU7g+-K0CrF@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 21:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBC8M-00026A-7M
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab0J0T6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 15:58:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45189 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0J0T57 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 15:57:59 -0400
Received: by fxm16 with SMTP id 16so1067993fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=2yZsN8+ScWAv78eRXjbbcwO6g6Bg/QOUBgL+7ZBWyJw=;
        b=iTJ4D3AbuQjsMa0NpNLQGtYLWSFTxDzd66AZtR0BoX1Dr9Xh3Uq03olU5ZALAO2VbF
         haT961hFfoAoK/LrrNeqAQNE0MPnmb4WEWL/dBGBRcNtr2miCl/WjZ10sY7mKQDGde7I
         413BOUf/jf21oATINlURmjHi/u/ZIAFNHKyIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=jbBtUbBGoMMulSQi9Po6VACWMaCa3gMDDsBNRI3tcu0BKuQfqzHDdi7kuouFPL4Ghj
         k5800vnJMNLeTI0RIjl9KcAlHo4rrj6BU8CYTBRkeyfAIfm6NtS9A2EuIFN7JZcfc6OB
         S/qBUq+Bue+lwawJ2elv/ichFhLUJ/wuZSyEM=
Received: by 10.223.70.136 with SMTP id d8mr2943222faj.3.1288209478689; Wed,
 27 Oct 2010 12:57:58 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Wed, 27 Oct 2010 12:57:38 -0700 (PDT)
In-Reply-To: <AANLkTimPfnH0n4xG0bxyDKT5j2aQEXKKZtU7g+-K0CrF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160120>

On Wed, Oct 27, 2010 at 10:42 AM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> On Wed, Oct 27, 2010 at 8:13 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> --------------------------------------------------
>> [Graduated to "master"]
>>
>> <snip>
>>
>> * as/daemon-multi-listen (2010-08-30) 2 commits
>> =A0(merged to 'next' on 2010-09-30 at 8083bf4)
>> =A0+ daemon: allow more than one host address given via --listen
>> =A0+ daemon: add helper function named_sock_setup
>>
>
> Thanks. I've not rebased my win32-daemon branch to master <...>

Uhm, that should have been "I've now rebased"... Sorry for the noise.
