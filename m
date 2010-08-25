From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH v2] Add global and system-wide gitattributes
Date: Wed, 25 Aug 2010 11:55:22 +0200
Message-ID: <87d3t7ow39.fsf@gmail.com>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
	<1281977813-6528-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Henrik Grubbstrm <grubba@grubba.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 11:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoCiU-0007gr-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 11:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab0HYJzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 05:55:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40466 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab0HYJzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 05:55:51 -0400
Received: by pzk9 with SMTP id 9so107345pzk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=T3IVttra7/SPgQPc91ayRaPoFjSF2COJBj0sneEJTj4=;
        b=Rt/IlAgBLovA4Z9NKfvG0KaaHg9Kw+YY2IPkx84CHzRc33VfGYJjwnCr+M7KCf74wr
         Rjqg2Zx7SueRlXZBxFcZKIzToYut3AQwCHX+ionN7L1PqhiIUI+30GwNJOeglTAFRJ3v
         oUju6q2NlDo0cIRCPOJMirybetpBmjgfvUwWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=FoyYlUXrFrGU9VOMRYDwyzZ4ErgaRgOAhGFyu6bK7mngRM06xniIIMOJqV4aZcKI10
         zrhQHH67duvuwjrh/s+RccsYbW8agZyjsMAVVqA7ccPZzBngEfHpPWWiCM2bjX8Eu19o
         hxhNH//VcSvbFAhf4LcriQKjf1+m52GECTzf0=
Received: by 10.142.172.1 with SMTP id u1mr6865037wfe.137.1282730150872;
        Wed, 25 Aug 2010 02:55:50 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id n2sm1298330wfl.13.2010.08.25.02.55.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 02:55:49 -0700 (PDT)
In-Reply-To: <1281977813-6528-1-git-send-email-gsvick@gmail.com> (Petr
	Onderka's message of "Mon, 16 Aug 2010 16:56:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154437>

Petr Onderka <gsvick@gmail.com> writes:

> Allow gitattributes to be set globally and system wide. This way, set=
tings
> for particular file types can be set in one place and apply for all u=
ser's
> repositories.

[...]

I really can't wait till this gets into Git and I'm certainly not the
only one (thank you so much for working on it, Petr!). Any reason the
patch still hasn't been applied?

  =C5=A0t=C4=9Bp=C3=A1n
