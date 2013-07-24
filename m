From: Konstantin Konovalov <kostya.konovalov@gmail.com>
Subject: Fwd: Online book has incorrect link
Date: Wed, 24 Jul 2013 16:46:46 +0400
Message-ID: <CAJs+qGt0tYiuL06Djc_gKyZdOJ3_O=c3HFMD-41cX_Wzdj+qig@mail.gmail.com>
References: <CAJs+qGv2k=JprxpQqKcYdn8_t-95Qw_vrdZ7Om6BEo=G3XZatQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 14:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1yT1-0000W1-TG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 14:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3GXMqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 08:46:50 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:53203 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3GXMqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 08:46:47 -0400
Received: by mail-ve0-f173.google.com with SMTP id jw11so6825568veb.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=UlY++C5VfkylN5cJ4zUiwFfaEa2WgCd7DGRbBLHUpmc=;
        b=ZUoLqG0/EUmbRuoJMTU5wGCOS4hhFIfGReJhJ71wfT04PD1dmhckUQJU5EUISAbI6F
         iL9NWkeyD62tXKkwVBJOytwpDePxyJkQlo3cb9sJYLeCvVGydDKtkqUl2TTaJgeSo4F1
         oRLFhur1ivw3yP9NRMgs1LoEzSaI981SQTTbRgN/HrTZd+J02k3pAVMxSKsOUFHO/VGL
         jqmmIQ15WzAC/rsoKCOjuKNvBtaR7FzGfRZAepmFNCtf1lOn1CjAb7Se6NwESwoCh3X0
         3W30E7tkKX84v5Utts0I30hL/HiflE0EI7wXLN1t6sW8Vbcjhx0hiywvhlT//BqUKS3F
         u9gQ==
X-Received: by 10.58.236.70 with SMTP id us6mr13963975vec.89.1374670006897;
 Wed, 24 Jul 2013 05:46:46 -0700 (PDT)
Received: by 10.59.7.3 with HTTP; Wed, 24 Jul 2013 05:46:46 -0700 (PDT)
In-Reply-To: <CAJs+qGv2k=JprxpQqKcYdn8_t-95Qw_vrdZ7Om6BEo=G3XZatQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231094>

Hello.

During reading the online book (http://git-scm.com/book/ru - russian
translation) I found some bugs.
1. Chapter 5.5 (http://git-scm.com/book/ru/%D0%A0%D0%B0%D1%81%D0%BF%D1%80%D0%B5%D0%B4%D0%B5%D0%BB%D1%91%D0%BD%D0%BD%D1%8B%D0%B9-Git-Maintaining-a-Project)
is original english (non translated).
2. The link (anchor) <next> at the bottom of this chapter follows to
chapter 5.4 but not to the next chapter.
3. In the contents I see chapter 5.6 but it is copy of 5.4 (may be
chapter 5.4 and chapter 5.6 the same).
-- 
Best wishes, Konstantin Konovalov
