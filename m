From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 08:00:51 +0200
Message-ID: <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 08:00:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAGcL-0005fv-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 08:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab0EGGAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 02:00:52 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:38608 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0EGGAw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 02:00:52 -0400
Received: by iwn35 with SMTP id 35so954391iwn.21
        for <git@vger.kernel.org>; Thu, 06 May 2010 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Abcf4Aro5uiqQVMkq/lexOQzk9u48WBCHkX44zqkboQ=;
        b=qYlU8Nn84YyiOgbomcNqrzu08mzde/QIvY20su99dpFaBgkr60ppABPwYgR4LbGrAs
         gzmsGkTuBAY4HtOfuQuMMyUsp43OonW32dk5l8frJ4UH4w/fc4PBAWqqRPUfEbQeZEio
         NplJnv1ueLANPX/UAS4OzatL8uOKJIevtRz7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qaTW8Dobvxh6XDOT2PKSFpfFl+rNVtk19IvTRPpKQdkAc5tkZTPktCNaDL8/3ADm3y
         uu8T9RTmvVwxfy6J56XYyAhgbBS13/6UM34SIdZutPRWDwdVBjSg8fL7OujYGezY+8oi
         Ah/5aIwpYiwKxyPqaHvmJ3uwfPMeLksTEBcXQ=
Received: by 10.231.143.137 with SMTP id v9mr3345909ibu.70.1273212051199; Thu, 
	06 May 2010 23:00:51 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Thu, 6 May 2010 23:00:51 -0700 (PDT)
In-Reply-To: <1273180440-8641-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146525>

On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>
> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>

So you don't agree to the Developer's Certificate of Origin, don't you?

Bert
