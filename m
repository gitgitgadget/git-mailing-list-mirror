From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 0/3]
Date: Thu, 14 May 2015 17:17:49 -0400
Organization: Twitter
Message-ID: <1431638269.17436.2.camel@ubuntu>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
	 <xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com>
	 <xmqqegmikj7z.fsf@gitster.dls.corp.google.com>
	 <1431635466.17436.0.camel@ubuntu>
	 <xmqq1tiikgwb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:18:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0W5-0000e4-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbbENVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:17:54 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34422 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965116AbbENVRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:17:51 -0400
Received: by qgfi89 with SMTP id i89so44198798qgf.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=FRjispOUVl0CZYil0xafNLEVBFWvQx4l2jvP8Snt4ls=;
        b=EnN73CCRVKnETpYOGu1r75dtVcHWmn1G1CI8DShXvIEdqLjto+9wLTSMVqCSrVCIRg
         xJLmJ3DQ4ogPRQfnRvjL6+/jNBxKLGFJhomjkjScgzynQNtSPACmif4BvJvTIaI6OXTi
         qaiPwivGRUB9n/nasWZDbo9WlZeChiyAEs13tLxsWzkn1/df11V6aIKRZYo/jRsKg3Dn
         4XuvqspmSkp9kzpCTxcl1AHqg4Vj8cj1E99AGohMGet2+jhLbeipCG4VLZFiC3M2Dvp1
         h1v69yaZ+453JJ/0gDO5GG6GlwzV5buI7QGwM5H6U+QIkXbFqrmygYBOV/1OfLGZnXPR
         123Q==
X-Gm-Message-State: ALoCoQlQ1fbjsIEmJE4r+M8twugw3lErLK+Y9pvND9rcZGRufFWAAmh3+XFyaNbmXGzC5eZLG9tJ
X-Received: by 10.140.145.88 with SMTP id 85mr8650859qhr.39.1431638271365;
        Thu, 14 May 2015 14:17:51 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id p81sm185282qkp.6.2015.05.14.14.17.50
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 14:17:50 -0700 (PDT)
In-Reply-To: <xmqq1tiikgwb.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269100>

On Thu, 2015-05-14 at 14:07 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I sent v10 in response to your last mail before getting this; I will
> > replace it with a v11 which includes this instead.
> 
> Yeah, I noticed that our mails crossed.  I'm deep into today's
> integration cycle already, so what I'll push out will use v10 with
> the fix-up for now.

That should be identical to v11, so that's perfect.

Thanks.
