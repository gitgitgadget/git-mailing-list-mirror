From: Jiang Xin <worldhello.net@gmail.com>
Subject: Really big update of git.pot (273 extra messages need to be translated)
Date: Thu, 3 May 2012 19:07:12 +0800
Message-ID: <CANYiYbHBeabd3DV51Z-R-C13QppXvQ+k8AsX0pczLRhCjYpqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Thomas Rast <trast@inf.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 03 13:07:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPtsW-0005vn-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 13:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab2ECLHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 07:07:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42416 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab2ECLHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 07:07:13 -0400
Received: by yhmm54 with SMTP id m54so1598811yhm.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=AyEI6gYbl3PpKmtjD1swW45wtmzr+Z5G7qH7y1WeM8E=;
        b=ohLrmBjmrOQ+qQdWieqkhBvYEdvXNyde0r/i2C7myXmjtOoWhGVLPmAqUB4TMTjA7K
         lnqLcRaz26U4VVKh622yeoa+AHOWo7Vhwk7eRlwYalP+CtCCU5vkz0+zKeLUjCfo3VqA
         OalysDR4WyDqHR8VKxi600vR8d5o3etq2B9SscUtgtMzULcD01NedB3YrNgNnrrywpQH
         6A5VNt39vBptZoqrQqyVvfuhSPBaj2NPN6ABKgCLeTIDurkirJIesk4WN3uSbhyVvYcL
         JbRBBeKY2fdQ43sd7CnbGyVgRpBTAT2bAXvmaK70wjVElnLovd8nVFeLYAc2zQYF4hhX
         6H2w==
Received: by 10.50.36.195 with SMTP id s3mr448683igj.27.1336043232741; Thu, 03
 May 2012 04:07:12 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Thu, 3 May 2012 04:07:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196896>

2012/5/3 Thomas Rast <trast@inf.ethz.ch>:
> I think it's sufficient to
>
> * not put _completely new_ translations in maint
> ...
> * not submit pull requests late in the rc phase
>

I agree with you.

I saw Ralf had already applied patches sent to this list from you to
ralfth/git-po-de repo.
Do you agree with that use the ralfth/git-po-de repo on GitHub as the
official repository
for German?

If all team members agree with that, not forget to update membership list in the
TEAMS file, and coordinate your work using GitHub pull-request.

Cheers for another big langage support, even though it need extra work
to polish.
I just update po/git.pot in master branch of git-po. It's really big update, and
there are 273 new messages!

$ po-helper.sh diff
Difference between the orignal 'git.pot' file and the new 'git.pot' file:

 * Add 273 new l10n messages in the new 'git.pot' file at lines:
   41, 46, 55, 67, 74, 79, 89, 93, 97, 101, 106, 110, 142, 148, 155,
   162, 169, 176, 183, 190, 197, 204, 286, 290, 301, 308, 313, 318,
   327, 411, 416, 420, 425, 430, 952, 957, 962, 967, 972, 977, 982,
   987, 992, 997, 1007, 1012, 1016, 1021, 1026, 1031, 1036, 1041,
   ...

 * Remove 15 l10n messages from the orignal 'git.pot' file at lines:
   803, 821, 838, 843, 912, 1356, 1377, 1454, 1458, 1464, 1471,
   1517, 1819, 1824, 1898

-- 
Jiang Xin
