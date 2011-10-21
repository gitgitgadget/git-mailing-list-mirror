From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 14:44:00 +0200
Message-ID: <CAKPyHN2hM9jDWkJwaP5ETfJnupQ6kAZjvAL_oaDumApup0-zOQ@mail.gmail.com>
References: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
	<1319180973.5352.8.camel@bee.lab.cmartin.tk>
	<20111021114952.GA2797@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Fri Oct 21 14:44:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHESt-0000nD-Kr
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 14:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1JUMon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 08:44:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54450 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1JUMom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 08:44:42 -0400
Received: by vws1 with SMTP id 1so2875959vws.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rtuOMlI4yMVkVBud43LgAY3gPNHJ0HYNxx5nhjJjx7U=;
        b=OVe5+7gmSyJMZi3u2Qq247+j0qgZegt5KEc4397rZYqYK8yJiwAThfSVvjP3lWpP19
         my+eYt7lEoupfB3g80+sv+Y8jbEbx1YodDDZ5xP9THTftHGSR5ApTUKUwP/LFnzwuDV4
         QjQSNc3z7hbDEwBfamfRHGPvmukYxNYNSHjFM=
Received: by 10.52.69.9 with SMTP id a9mr14899523vdu.17.1319201081009; Fri, 21
 Oct 2011 05:44:41 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Fri, 21 Oct 2011 05:44:00 -0700 (PDT)
In-Reply-To: <20111021114952.GA2797@lars.home.noschinski.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184059>

On Fri, Oct 21, 2011 at 13:49, Lars Noschinski
<lars@public.noschinski.de> wrote:
> =C2=A0- automatic usage of pager
> =C2=A0- support for pathspecs (can be emulated with `find ...`)
> =C2=A0- support for boolean combinations of regular expressions
- thread parallel

bert
