From: "Rado Dr." <radodr@gmail.com>
Subject: Re: git status & seg.fault
Date: Sun, 7 Nov 2010 10:31:56 +0100
Message-ID: <AANLkTi=3eeZteCBAPoQUq3PCqkRssfnNPc8x+=yaQ3N1@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
	<AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
	<AANLkTinfrkp6_AG=G_hHiWe9t0ke=bm_pg=_ecShXsbB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 10:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF1bX-0004RS-MK
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 10:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab0KGJb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 04:31:57 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46983 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab0KGJb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 04:31:57 -0500
Received: by gyh4 with SMTP id 4so2889230gyh.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yo8fJEI87qX5QM1YrLGMn3Ol0YiN0sF5OQUoJ/0ml8A=;
        b=cdGdmKETsxx8MT7GulrNbXoJZHlb871CSP0IXTu0cLzRCNW6F83koBUR0VCSP53F6J
         h4uCtooOFsBjlBZVmCVsncx4KXtyzGxbHYoBseqVgIMtjaHrKNUt8AXjALoCBCyWbYuJ
         drHN+ol2E/Hj7JFe8YnzEixmSRG35zblfBUxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qjK8I+aaMdga5Q7PPu8QRFP+WgA/PsUkljL+FCYoWAIbg3AkL/yk9rmHu4urSLF+Kt
         NDmbWCsrmx8UGJJmsxdTF+nGT5khbvc6Y9r7l/hXQqTuKv+u9v0PHuoc/fIYSayyDkVY
         vs5xkhzoduoF8jMstmJVpNbb+/SRJPuJ0Yk2I=
Received: by 10.151.83.13 with SMTP id k13mr6600001ybl.54.1289122316345; Sun,
 07 Nov 2010 01:31:56 -0800 (PST)
Received: by 10.151.49.3 with HTTP; Sun, 7 Nov 2010 01:31:56 -0800 (PST)
In-Reply-To: <AANLkTinfrkp6_AG=G_hHiWe9t0ke=bm_pg=_ecShXsbB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160870>

No, i don't resolved that problem. I had to use that repo so I had to
recreate my git dir from source backups. Now I don't have any
problems. I don't have that faulty index now.

Rado.

2010/11/7 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Tue, Oct 26, 2010 at 1:44 PM, Rado Dr. <radodr@gmail.com> wrote:
>> Hi there,
>>
>> I have "Segmentation fault" error after "git status" command in one of
>> my local repos. Just i one repo, other repos are OK. I can't find any
>> clue how to fix it, and as usually I need work with that repo ;-)
>
> Has anybody resolved this? If not, Rado can you send me your
> $GIT_DIR/index if the fault still happens?
> --
> Duy
>



-- 
Rado Dr.
