From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit] Emacs mode merge request
Date: Wed, 16 Jun 2010 10:06:45 +0100
Message-ID: <AANLkTim2s_Q-tBV774g2ygtbrfuoo7ujlzovMa8SKyZD@mail.gmail.com>
References: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 11:07:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOoaq-0001DU-5C
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 11:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0FPJGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 05:06:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0FPJGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 05:06:47 -0400
Received: by fxm10 with SMTP id 10so586306fxm.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7j3EO9UuVv9sGNT7PNJfxZtL+ci4eQYwt/1ysVmIwz0=;
        b=A5Z7zVtJbb0K2hrM+vEB7SDkRTaqo3esPZTt+3Lk0gOg0JF8uyACF3ufcVRbCGNkwv
         dMPk/BD/L0he7mQlUkvDmj6HCW6InVToGqur38sUdU4pID5v0IXk1Lj0bNm1LNLP+0/Q
         oO+VES0O+0bM++BcOq7C8o36WpV5+HOcBBYCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f7IYnYfOcrIPAvCrnv0noRDkxopPrZf/lFRX693bPArluekNTLf+FY9Qcl0u9xZ9P2
         mENQpca0Xt1P9KfCB4sc9pLTy4yG57i0iwxCebKFr7ySzeqQGgfhd0w/ewS6nxDFDXnO
         KOo3/mdzkFuN/XxRimBlTVPBFYshmhsNpRYQQ=
Received: by 10.223.56.206 with SMTP id z14mr8684665fag.97.1276679205601; Wed, 
	16 Jun 2010 02:06:45 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Wed, 16 Jun 2010 02:06:45 -0700 (PDT)
In-Reply-To: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149259>

On 9 June 2010 13:11, Gustav H=E5llberg <gustav@gmail.com> wrote:
> Catalin, can you please merge the following series from
> git://github.com/gustavh/stgit.git "proposed" branch.
> All the patches are small, incremental improvements and bug fixes to
> the Emacs mode.

Done. Thanks,

Catalin
