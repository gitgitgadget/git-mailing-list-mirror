From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Really big update of git.pot (273 extra messages need to be translated)
Date: Mon, 7 May 2012 17:51:26 +0800
Message-ID: <CANYiYbHgacnGZqZxzvoBtNY6nCtMTYrAOPja+Qv8iO+wo_LJ_g@mail.gmail.com>
References: <CANYiYbHBeabd3DV51Z-R-C13QppXvQ+k8AsX0pczLRhCjYpqfw@mail.gmail.com>
	<alpine.DEB.2.00.1205070958550.11690@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Marco Sousa <marcomsousa@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon May 07 11:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKjA-0001uk-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2EGJ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:58:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63956 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab2EGJ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:58:50 -0400
Received: by yhmm54 with SMTP id m54so3978477yhm.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=33A/zlzr0fWI4TkXxrBqaOlLFZ46NtTg3XbsT48yONU=;
        b=UNBnmOp7wimvmDZ6yXCS8T38P+tAPrUS79bHy6M9DN1Pnk34wHDlwiZqFv0CRPH2mZ
         4MRAT6XvGKtWB+zbY5vXqIx5Nv0BzwFAjXh+MV/mLmlt9mbGXPQmrLNOPyvZb1Vom1Qq
         AhH+8bEP7L0ehRgOv4ECWN/VgWhZrNOlYDm5FFK9bwdN2IEAadVX7xMGrBc/SBVvNE6C
         0Vl46vL2iDlvsJvyVcj4TRrqjgGcCflF3216Bprg2cAmYIphdQiLhyHDlHLZuVD6ajEx
         W3kKDofqHQTUPlfvCyexX8paN2q90QMf/FFHjuJhvIGBtHXk27HArND8SfG2vPLajW4D
         X9hA==
Received: by 10.50.189.135 with SMTP id gi7mr7953539igc.37.1336384286319; Mon,
 07 May 2012 02:51:26 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Mon, 7 May 2012 02:51:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205070958550.11690@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197253>

2012/5/7 Peter Krefting <peter@softwolves.pp.se>:
> Jiang Xin:
>
>
>> I just update po/git.pot in master branch of git-po. It's really big
>> update, and
>> there are 273 new messages!
>
>
> So, which branch should I update the translation of; maint or master?

Both. ;-)

The maint branch tracks l10n for 1.7.10.2 (next maintenance release),
and the master branch tracks l10n for 1.7.11 (next release).

Update for maint branch is easy. There are only 2 new messages for
sv to translate. The master branch has lots of updates (200+).
Keeping the translates for master branch uptodate regularly would
make life easy.

-- 
JIang Xin
