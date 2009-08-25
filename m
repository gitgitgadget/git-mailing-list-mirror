From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What IDEs are you using to develop git?
Date: Tue, 25 Aug 2009 07:18:38 -0700 (PDT)
Message-ID: <m31vn0m0xy.fsf@localhost.localdomain>
References: <000001ca257d$b60326c0$22097440$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?iso-8859-15?q?Frank_M=FCnnich?= <git@frank-muennich.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 16:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfwrJ-000060-BO
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 16:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbZHYOSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 10:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbZHYOSi
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 10:18:38 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:44658 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbZHYOSi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 10:18:38 -0400
Received: by ewy2 with SMTP id 2so466960ewy.17
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=wOlJD5geYgXGN0vcLLta1gt6Ncy3RfpSIJrRWY31650=;
        b=c/5dq+35CBDnT9SG1rkYTm7uh7GO/IW/9CFhJm29pSrB3N+gdlXehQD+nELA0ARCRq
         80n41saBbXzB5rWF2a5fvaaojce6qVvcTSmvetUNabm21Z26VmQItGyiABWYfQUoL62x
         0qGMOpX1bbbu7kzANMnVDoG7rcdBuGE+yDO3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Lq7YCukLaB166angbhpvhAxBLH01I3/Rtpj2iUCxoGkbk5IAv9TmPJt+1Vyo0A1tDp
         Y9J5ZZh6J1O87o+qsVsT+SjtlwMKK0AChH67/3gPHe2e+04zhW9ARO9tCs8vLTpPJypJ
         PPqV+A3iVsLtAKATaQpGL1mVUmOXSaCqEOafg=
Received: by 10.103.76.34 with SMTP id d34mr2715635mul.31.1251209918978;
        Tue, 25 Aug 2009 07:18:38 -0700 (PDT)
Received: from localhost.localdomain (abvm114.neoplus.adsl.tpnet.pl [83.8.210.114])
        by mx.google.com with ESMTPS id 12sm435065muq.29.2009.08.25.07.18.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 07:18:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7PEIZP6005800;
	Tue, 25 Aug 2009 16:18:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7PEIYw0005797;
	Tue, 25 Aug 2009 16:18:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <000001ca257d$b60326c0$22097440$@com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127024>

=46rank M=FCnnich <git@frank-muennich.com> writes:

> One thing I would like to ask you: what, if any, IDEs are you working=
 with?
> I tried Anjuta but were unsuccessful in importing the git folder from=
 any
> branch into Anjuta. Eclipse worked a bit better, though I am still ba=
tteling
> with the debugger a bit.
>=20
> Any recommendations, manuals or how-to tips are greatly welcome.
> And one thing: thank you for your effort! Git really caught my attent=
ion and
> I was so much amused by the Google-Techtalk that Linus gave about Git=
, that
> it sparked my interest in relearning how to program again ;)

I personally use GNU Emacs when working with git-controlled projects.

See also question 20. What editor, IDE or RAD you use working with Git?
in Git User's Survey 2009 (http://git.or.cz/gitwiki/GitSurvey2008)

   Among text editors (although with plugins, addons, modes one can
   make those into something resembling IDE) Vim with 51% wins over
   TextMate with 33%, which in turn wins over Emacs with 21%. Next in
   turn is Eclipse with 13% (assuming that editors in 'other' won't
   change it; this would a bit unlikely, though); it is most popular
   among Java IDE listed (from those NetBeans is more popular than
   IntelliJ IDEA). XCode, MS Visual Studio and KDevelop IDE have
   similar popularity, surpassing Anjuta.

--=20
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
