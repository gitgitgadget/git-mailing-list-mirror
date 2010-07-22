From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 17:33:57 -0400
Message-ID: <AANLkTil2ZHsV-PH46wfeqqvB27akRw3egDWRtJbIPLXb@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<20100722195653.GC4439@burratino> <AANLkTilhKR5wuJPPIF1SiRcTJ0fmz1oqp_NfuSSuKMOn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 23:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc3PM-0003lV-2I
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0GVVeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 17:34:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43858 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab0GVVeS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 17:34:18 -0400
Received: by wwj40 with SMTP id 40so3955122wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OTtQ5D6XQCiQntZH602+IHX8fwyx2gNG6eeZhAc6n5Y=;
        b=npecRU4QHCjQYdQAR4HEcq63m3uWfBpY4ndauUVHjZIfjTMNeanP513Qpq3nYgooRx
         rdtZfxEaoepbnPXgKZCREZcGLYPrw6K3ylRAVW0gwtBeM3sAVPf3cU0eP50UfoXncvzD
         QxwzVxfUa90G3zH62bSxDBNKBJdH0ru+B36PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fUeSYp7+Jv5zQPeaFrl1ZtuoY/BkhbIK6etnNgVZmpBlMcMzb3VgyEGPEDpI+SkIhP
         JfupdcF9KIF8LWiGcJNhCnYaSySP5tDdhRJy+z6gfo7G9mWxPUdxe+rdCEg8u1ZrH6aj
         5okY1ilZIbAQNV9/Oy9kiQVDQa1s1Wbf37gY4=
Received: by 10.227.157.200 with SMTP id c8mr2549362wbx.69.1279834457222; Thu, 
	22 Jul 2010 14:34:17 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 22 Jul 2010 14:33:57 -0700 (PDT)
In-Reply-To: <AANLkTilhKR5wuJPPIF1SiRcTJ0fmz1oqp_NfuSSuKMOn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151487>

On Thu, Jul 22, 2010 at 4:17 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> But it's also clear that we have a lot of tribal knowledge about the
> lackings of git submodule / git subtree. It would be *really* useful
> if people like Avery and Jens which have obviously thought hard about
> the submodule/subtree issues would draft up some (calmly written) doc=
s
> about how the two differ (with comparison tables etc.).
>
> That'd be a very helpful resource for Git users in deciding which one
> to use.

I think I'm too biased to write that, but if someone else wants to
take the lead, I could certainly contribute.

Have fun,

Avery
