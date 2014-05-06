From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Wed, 07 May 2014 07:46:10 +1000
Message-ID: <fa80985d-6420-4eb5-8623-00e2d8e8e798@email.android.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com> <xmqq7g5yehf4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 23:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhnCG-0006CV-2w
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 23:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbaEFVqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 17:46:39 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41620 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEFVqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 17:46:37 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so82545pdj.34
        for <git@vger.kernel.org>; Tue, 06 May 2014 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=eV3VNjQJF4kDy6mgo0YeAZzEuTYKjhy47BqC8FPMnZU=;
        b=aQdq8KGUvCBnY5laGPCf8IKxRz5JGTsLM/6+Eo5+Uu4KdVYSKlpUI8t5cDpGcKFnMp
         zbkxUmYVDHbhS3nJD+dL6FNasYrckpzO+BvqWtD8/qVyqEL1tY88NceQMNgCh/HuE3W1
         QLwVmigpH939nfA/0143899liV4hcgMzHTwfOCVl/InkXMFs2COYMGlthIFgO8tkSLnm
         B9J7lXN29s+BfkN0hbXhuJJErVZeXjr/YKpceY04ta25Y+sAL+yqSwhA5/WIBqkAxE1f
         MfjesPSkYX4oui5u1m4sKU86J0ZLNeua4see/UpB9XVVQGKyRsB866gaFVzTdbgH2XQ5
         XR8w==
X-Received: by 10.66.164.135 with SMTP id yq7mr10978942pab.126.1399412796520;
        Tue, 06 May 2014 14:46:36 -0700 (PDT)
Received: from [10.94.13.52] ([101.119.29.160])
        by mx.google.com with ESMTPSA id ai11sm51187557pac.30.2014.05.06.14.46.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 May 2014 14:46:36 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <xmqq7g5yehf4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248255>

Junio C Hamano <gitster@pobox.com> wrote:
>It is funny to see sign-off on 0/5 ;-)

Yeah, I wasn't quite sure of exact protocol, and sort-of defaulted to
sign-all-the-things mode.

>By the way, this is v3, not v2, no?  It was somewhat confusing to
>see Peff saying "filfre to add my reviewed-by" on v2, noticing you
>posted something new, and not finding v3.

Ah, right. I thought that resending a post-discussion patch was the done
thing, given Documentation/SubmittingPatches, but that a comment line
might not have been worth a version bump.

>Will queue.  Thanks.

Awesome, thanks.

Regards,
James Denholm.
