From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 16:02:11 -0500
Message-ID: <53582a537972f_24448772ec83@nysa.notmuch>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
 <xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
 <CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
 <xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4YN-0002Bi-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbaDWVR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:17:58 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55048 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125AbaDWVRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:17:55 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1686652obc.38
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zsYsiBD5KtGzeMJPYo/hb9wnvMxu1kDGnSRQWPajbOA=;
        b=M0mYnNM/SWnUK+AbZh73cz1qJcJ0J6rZ3cJCykJzir3+7v7kXom/cTMfsnF2CTHcE6
         LwrSV69rXKMlTO9qltQhWlqK/Xo0xoRpPEjYbyRtO+ia1kDdsac0f7gHBlEVDNhZg+m2
         lIciS7BOC4FBT6QzpCqg1ungM/1+yG05qmOOrbM91+hYvAHRKT6dP4elTneBxHK/oaDJ
         XC6VILgkWw8daceMpvJU55KhembR4wOd50TT7Jk8AaQbfLXBe7UGJfgf8xjHRXDOOqae
         ahynhyQ7rDxCMMHYMBIG5Upr+zrW+r1vwQSIhtlp+2nR73vs31NN617nHnUz0+WrzhjZ
         Y/WA==
X-Received: by 10.60.54.38 with SMTP id g6mr2522644oep.79.1398287556953;
        Wed, 23 Apr 2014 14:12:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id su13sm8514964oeb.9.2014.04.23.14.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:12:35 -0700 (PDT)
In-Reply-To: <xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246898>

Junio C Hamano wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
> 
> [Administrivia: because people read from top to bottom / why is it
> bad to top-post? / please do not top-post.]

https://en.wikipedia.org/wiki/Posting_style

-- 
Felipe Contreras
