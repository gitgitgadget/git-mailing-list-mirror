From: Ron Eggler <ron.eggler@gmail.com>
Subject: Copy branch into master
Date: Mon, 28 Nov 2011 10:25:33 -0800
Message-ID: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 19:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV5tb-0001Dt-8V
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 19:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab1K1SZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 13:25:34 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42747 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1K1SZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 13:25:33 -0500
Received: by vcbfk14 with SMTP id fk14so3907056vcb.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1gZD2InUCJKQKs4nkdGQnyuoEgKOp1R78x/PWIkk2gk=;
        b=ugmJlDrk53rbxh5WcAItbo39VFBDmQ3IV5PTVik6bm3YA6a0SHY5n8m35IbpKGTDIP
         s7ayHYgLom+RPrr77I9MLDQ15/vLj9bsAHzkPpLVRImgVwls2xReG2bhLU6bBt6227NU
         K5+4WDKpA10ptxhdUFqvjFYhU/0yum0FgeuQA=
Received: by 10.220.152.81 with SMTP id f17mr5076918vcw.194.1322504733096;
 Mon, 28 Nov 2011 10:25:33 -0800 (PST)
Received: by 10.220.4.82 with HTTP; Mon, 28 Nov 2011 10:25:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186024>

Hi,

Some time ago I created a DVT branch in my project and I have almost been
exclusively working in it. Now the time for some test deployment came and I
didn't have time to merge it all back into the master thus I gave out the
DVT branch version. Now I would like to copy exactly what I have in that
branch back into my master to have an exact copy in my master of what got
deployed with out any changes.
How can I do this?
Please advise.

Thank you!
Ron
--
Ron Eggler
1804 - 1122 Gilford St.
Vancouver, BC
V6G 2P5
(778) 230-9442
