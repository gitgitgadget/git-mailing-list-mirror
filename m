From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Remove some junk characters from COPYING
Date: Sat, 16 Jan 2010 09:22:27 +0530
Message-ID: <f3271551001151952mb7b810ft2264dad92fb79099@mail.gmail.com>
References: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com> 
	<20100115222811.GB18878@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 04:52:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVziY-0003Ak-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 04:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752Ab0APDws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 22:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235Ab0APDws
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 22:52:48 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50823 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab0APDwr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 22:52:47 -0500
Received: by ywh6 with SMTP id 6so1119066ywh.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 19:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hAmUy7rKyJVury1ZkIt6CBXfJ8BbBUIFj9IAwbEf5Gg=;
        b=d8xH/XUWu6R2eLT1rDb/IsiFc+LdYlhb8SDiS+kp/38MeVWWbqZil4+UVsnx1UicQ0
         VgPvbr6hXu1NEXgORdVk3TuCsEQw6Zf2dkpK/BVHNdO8d5PI4vsBQgogglghE1saaWxo
         Kqg3ZgFAxTDG6oFYfGFe+ik7itPVGSU/E+l2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cQc7hjOCQxHPj82Y5AavQQ1mf8lD3fjnsc7xSSWVkXdUq0DLxAV2JUSbHS2PTdnyAJ
         /7s4ye1do/wGXHHUJa3uhF4b1iZoq8Rbf1FK+bBQs+CLFqsqA52L8Mfemf54tiF33BZf
         fordn1y9Rbh7238kK6STXTdfZkvu2RVfgfg10=
Received: by 10.91.161.28 with SMTP id n28mr3178398ago.84.1263613967095; Fri, 
	15 Jan 2010 19:52:47 -0800 (PST)
In-Reply-To: <20100115222811.GB18878@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137195>

Hi,

> http://git.or.cz/gitwiki/GitTips#Usingmsmtptosendyourpatches

Thank you for the link! Yes, I know about git send-imap, but I my
firewall blocked traffic on all ports except 80 and 443 until
yesterday. I jumped some hoops and got a few more ports opened up for
myself yesterday, so no more attachments in Gmail :)

> I'm sure there are other ways, but that's the one that works for
> me. =A0I also use mutt to read gmail; also highly recommended :)

In that case, check out Sup. It's *much* better than mutt :)
