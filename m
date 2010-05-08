From: amitesh kumar <amitesh.a.kumar@gmail.com>
Subject: Git Master Master Replication
Date: Sat, 8 May 2010 11:41:55 +0100
Message-ID: <o2tc2f2fad1005080341z42b389e0i791c6c7a02dee5e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 12:42:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAhTu-0004zA-SR
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 12:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0EHKl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 06:41:58 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:49791 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0EHKl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 06:41:57 -0400
Received: by ewy20 with SMTP id 20so491536ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=+natSaDhpIJiOkAoLRBEmloVHQ7+ee53qHLiAX44nHI=;
        b=DBL1OP2Z29oBYD+kMjF5h+WeIOGfKFWAx+MxOq5959UR5dubzR4dPA/QjR3UQctKxO
         2e9K7xD1cgFmnZp0U32Ag2g4u8DMcFYnYD9+zHD5lELBTsyfVuDiG7dzGR5xKo1hnPCi
         frjl3lR5PRlAkX1B/RL6knl4Yqz9o8XDCJgl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=b9fmANMPeyCZb5BI0xyRzH9zUYu8pimlV4szU6x2+b9in9neG4vRwiyUQTQDlBj3l/
         GrDHAxWP5IinMy97VNmCU/vHYEVCSwE0k88atD0LAjSspPYUYBsnM78NOIZpJ41Iu5gH
         ZlwUgik5fH8ce32VBe5JrLQx14ON+7WscMoII=
Received: by 10.213.37.3 with SMTP id v3mr580262ebd.11.1273315315780; Sat, 08 
	May 2010 03:41:55 -0700 (PDT)
Received: by 10.213.31.68 with HTTP; Sat, 8 May 2010 03:41:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146656>

Hi im working on a project the will be deployed in many countries,
Is it possible with Git to host n masters?
Can any change on a particular master be propagated to others?

I have had a look at Gerrit2 but it only looks one way.

Cheers
Amitesh
