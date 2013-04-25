From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 09:57:36 +0530
Message-ID: <CALkWK0=AxKnbOhmM+wAdAb4vh9HANfLHZmJ6bTWxN_8B9p_-XQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 06:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVDnA-0000QS-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 06:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab3DYE2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 00:28:17 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38150 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab3DYE2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 00:28:16 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so3131105iej.30
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9rjVmomc5RVdR4x7UZSfFwoUK9tVPB4KoCrk0/nAO9o=;
        b=fOUbIQljqNgM69JzDQ9C/Vxuan9AaENudLSviaOamk+xcxI8qmxk3TjrFWmQ7XaN+n
         DL0ZJtCuy9yTdEd97wabJ/4f9OpkTwt6Itrn4Iq677WHfgx+d1+Q9PcRCl3JmOBP+qb8
         Dx8Nwkq8FH/AYSs/X9dc9I8Drs3awjsoiK8H4m2BU0ZY3SeP2WzMiLUS7Iij+UlKKKIC
         Vn0WfQV/d40jigU4OUYLiEI7YnWnRKf0zOu4qD+IMIXsZE0W3xQO5mz+QTQYAeU73eLA
         9CUDgtlpZXg6hpzGTB4JBqql1XNP12Vf+VAOiIdVePZG3RbZqNn8N2+BkyBqd1q4Cwtx
         WIMg==
X-Received: by 10.50.57.116 with SMTP id h20mr1445726igq.49.1366864096176;
 Wed, 24 Apr 2013 21:28:16 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 21:27:36 -0700 (PDT)
In-Reply-To: <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222342>

Ramkumar Ramachandra wrote:
> We might still want it.  I mean what are we losing?

Actually, let's just look at extending the rev specs we currently
have.  I'll gather up a list of real itches and post it to the list.
