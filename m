From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Thu, 17 Mar 2011 22:10:39 +0200
Message-ID: <AANLkTi=Uyem4p=MJ--0d7+r8Dd8rnanDduQ+B_FtSRwV@mail.gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
	<1299590170-30799-3-git-send-email-alcosholik@gmail.com>
	<4D773570.4010803@drmicha.warpmail.net>
	<AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
	<1300371608.16335.1.camel@wpalmer.simply-domain>
	<20110317193450.GD20508@sigill.intra.peff.net>
	<AANLkTin35yjU-JDA8z4_aRFhV+-_hHiurWjaid8Th919@mail.gmail.com>
	<20110317195459.GA2257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:10:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JWw-00075V-QL
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab1CQUKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 16:10:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45175 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1CQUKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 16:10:41 -0400
Received: by fxm17 with SMTP id 17so3070380fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=odYAQYkbg75u4Y/5cgd+Z9xPjBTBjwxhP9knqQZovks=;
        b=n9L1LUHCf+nTv2//spdaf0djzful5TZ3y+NJi8YCC0EFzbMiTS84inxDmhgOXu/zRJ
         2tgPTgP9rk9TEv6U8u0fKYtkjOiAIrU+/q3PByOW3BYAJTGM8wzP6k0enkAypEcXTUi1
         0RP4HozOSTBWhJ5bn9ScUswzeU2yi6XzwppG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IGVOQdlRzNC4E6cZ3+Oh0YxoOIEKC2y8ctWCr2wLiv7H8Oa6Hba9RLumnUZqEQFJqo
         6b8oKkhfrqjQmWGmcr32YAbTDPS0D4RdlYHkbEoMA5UYvaN82YY7UlCyVR+Vq6zwk46S
         fOcRSI5Ftg/cd4PcHqb+E5q8HcZdc+2M2CEvo=
Received: by 10.223.59.146 with SMTP id l18mr229618fah.58.1300392639966; Thu,
 17 Mar 2011 13:10:39 -0700 (PDT)
Received: by 10.223.66.197 with HTTP; Thu, 17 Mar 2011 13:10:39 -0700 (PDT)
In-Reply-To: <20110317195459.GA2257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169272>

On 17 March 2011 21:54, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 17, 2011 at 09:51:55PM +0200, Alexei Sholik wrote:
>
>> I think, it would be nice to have a tool, which output all the
>> different stats about the repo, maybe even in a gui. But it definite=
ly
>> doesn't belong in the Git project.
>
> Check out:
>
> =C2=A0http://gitstats.sourceforge.net/
>
> It currently doesn't have a lot of per-file stats like this, but I'm
> sure patches are welcome. :)
>
> -Peff
>

Hey thanks! I've just found out that my current project has more png
files than source code files :)

The tool itself looks rough in terms of the output it produces, but
I'm definitely going to look at the code more closely. Thanks for the
hint.

--=20
Best regards,
Alexei Sholik
