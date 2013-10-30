From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Limiting disk usage
Date: Wed, 30 Oct 2013 16:40:11 +0100
Message-ID: <20131030154011.GB9691@paksenarrion.iveqy.com>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com>
 <vpqob68ebcu.fsf@anie.imag.fr>
 <CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com>
 <526FCA13.4090902@gmail.com>
 <CAA01Cso8J+BBgskoRtxkPRrtM4KJ1O2FhcB4uh+QB2Dr=DZGyQ@mail.gmail.com>
 <52712816.9010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbXv0-0005kV-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab3J3Pmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 11:42:46 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34791 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab3J3Pmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:42:45 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so1270655lab.9
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B2rLaWnAX8dvii0sfNm2WE1ppRwfWbTZjPt7hrye6n0=;
        b=U8HX5wFb2P+a0uqx+PM3bAyUgAFoPPQ6fIAfYjdz7wMM0vF66whxFqlrZ7UBQ9ZcaU
         66dAw1Dew73oAt4M1R7sCcAeg0ZxrwYdBFxXAjGsf69WIQY3GVRRdCWVgL/pqb8c25p5
         TiFX9UJTaSWL5ysgU2sFHlpcgiaEUZVjbHKoXIIJpJGYnMx0UQTE0U896IjLs3J6Tt7p
         GDryUL410TPcJw08atz3RCnglsfGICEXpVZFnd+4EXmByFp79TKnnLXouQR07j08zn9R
         0x/PedqskQmIpTttz+knNiQ1eWPzBV8gS0194LCfXdm0+ZSZ4is1KucZfsF/0jszPyGF
         tFsg==
X-Received: by 10.152.22.35 with SMTP id a3mr1710768laf.45.1383147764114;
        Wed, 30 Oct 2013 08:42:44 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id pw4sm20401111lbb.9.2013.10.30.08.42.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Oct 2013 08:42:41 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VbXsR-0006Sh-Ev; Wed, 30 Oct 2013 16:40:11 +0100
Content-Disposition: inline
In-Reply-To: <52712816.9010600@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237025>

On Wed, Oct 30, 2013 at 04:39:02PM +0100, Jakub Nar=C4=99bski wrote:
> From time to time you can find there ideas about adding "floating"
> mode to git-submodule, but as far as I know up till now without
> effect...

How about git submodule update --remote ?

--=20
Med v=C3=A4nliga h=C3=A4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
