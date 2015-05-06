From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Wed, 06 May 2015 19:07:49 +0530
Message-ID: <554A192D.7000102@gmail.com>
References: <55463094.9040204@gmail.com> <xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com> <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com> <CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com> <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 06 15:38:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpzWW-0003GE-9I
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 15:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbbEFNhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 09:37:55 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33164 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbbEFNhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 09:37:54 -0400
Received: by pacwv17 with SMTP id wv17so9833707pac.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ktw6LUGDLp3gTbGJFXXBNPC3IgPsIY7CVw7rbQnFJuA=;
        b=CFQssyRA1xqkzWSUZ3jPdWok2KGDgYMn0QZAFcW2Y7VGgL4d623svldOB+5jh3LXoS
         5E2A2SGVypKgH4OFyUacDaD66iX/RLLdR4Wh1mxrm5GfAhpoQ2UboxEoQlIZQTOd/r8B
         FGNRIhHI3peFNORq8Nv6XJgFnz2JkPCyx061RNnFaQq6otYoiRBayyu7wkxFPb77OHp6
         oSHY4YNvCa6oVUJi3aUI93mk4Nh8FCWeWlFIQbCGHk0Zv9BqSwebPlUbHWNOZJzhIswb
         nN/7rVHwLrEcWW10l6ZTqWHLJIS7Sa+PrMTjSk6Rk6JtgjYfuUj7G1f3hYIlpsgAPS6a
         5jLg==
X-Received: by 10.68.88.33 with SMTP id bd1mr61865235pbb.124.1430919474021;
        Wed, 06 May 2015 06:37:54 -0700 (PDT)
Received: from [172.16.0.91] ([182.48.234.2])
        by mx.google.com with ESMTPSA id b10sm1977447pdo.84.2015.05.06.06.37.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 06:37:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268466>

No other changes for now, apart from the changes suggested by
you and Eric. You can merge it into 'next'.

Regards,
-Karthik
