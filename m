From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] Maintaince script for l10n files and commits
Date: Fri, 9 Mar 2012 14:31:36 +0800
Message-ID: <CANYiYbEgrnB3yO2Gx=h=EGAfjpkTR78RjsbTP2ixsGB1fu5bog@mail.gmail.com>
References: <7v399iddw3.fsf@alter.siamese.dyndns.org>
	<1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
	<CAJDDKr7A1LN_r5v0yiacpEHTtEqQG2Hf=YZ6GbtsOHLadozDKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	avarab@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 07:32:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5tNI-0008UK-FD
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 07:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2CIGbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 01:31:48 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47882 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2CIGbh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 01:31:37 -0500
Received: by vbbff1 with SMTP id ff1so1129761vbb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 22:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ph8OrOXyeu8jyWYAdIkwk2I12bbRBImb+hXIdzTyy0c=;
        b=0Y3yhIsDcyGWkZQo0kLnWkNJE1T8cz2mL/F6OWu2xYiJM+AdKAtb43KJC33Tiedu5z
         /s1OG1u0zfeGHBNV5snlQLB+lT9ZsicZT6t56gETQQ/OGNDy2gX1JnasftmJpT3NwM45
         as8eFHdf5/Eu+UKvmrVbN1sSoUVJuu7WBWU+fUGJiPBib/oKvAzdZZltxaeyNN0/cNFt
         42zL8HAazz4sBD5BCcSElxAvJLE0lOVk3KOD/AA28KJvPZGKdY4YDsL2BpP4uhiWeayl
         5VSCjxMS+KJ5xiAXZNNWBVMDYgSiGtbRIiCCWDAdFDzHd0PXc5n4J2OLCw3m5dVU7Bg9
         XceA==
Received: by 10.52.28.178 with SMTP id c18mr1638957vdh.45.1331274696842; Thu,
 08 Mar 2012 22:31:36 -0800 (PST)
Received: by 10.52.26.37 with HTTP; Thu, 8 Mar 2012 22:31:36 -0800 (PST)
In-Reply-To: <CAJDDKr7A1LN_r5v0yiacpEHTtEqQG2Hf=YZ6GbtsOHLadozDKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192682>

2012/3/9 David Aguilar <davvid@gmail.com>:
>> +
>> +GIT=3Dgit
>
> I think it's customary to just write `git` in shell scripts. =A0It lo=
oks
> nicer then seeing $GIT everywhere, IMO. =A0I guess this could be help=
ful
> in the future but I don't see GIT being reassigned anywhere.

Just for easy to find the git command called, nothing else.

--=20
Jiang Xin
