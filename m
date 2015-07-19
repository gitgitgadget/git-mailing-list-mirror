From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] Various tweaks to 'worktree'-related manpages
Date: Sat, 18 Jul 2015 22:50:31 -0400
Message-ID: <CAPig+cTY4+e3rbDuRRhKajVP+xrBRVr3nZOsQCFiBtYyiQdvqg@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:50:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGegd-0005x1-QX
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbGSCuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:50:32 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34304 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbbGSCuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 22:50:32 -0400
Received: by ykax123 with SMTP id x123so117190112yka.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zwsskBwqM87fYPrACU9e3iG/0MAnl0gUQHvcqEQ52kg=;
        b=yVe0nNu2xzhK7b2Q9oL0nyS8N2YG7N4Gqq++jakQij774mu0ZnRkC7buN20IBmuyP1
         UbIMcZjdSKn4zdn0wHkRCr4xuX+my6M6gPsYnf1T3Oqgvei2Xhgye+XC6yf1BpWP2QRz
         agnRdG+ywPG9dI5AqzbfgjO+zIFOigO3/zp4me2PC1LE0JIzgpx3PCuoTQBnG3nHTBtB
         9pOy4cNDZ49hB13iHXbhMIpG1r+hJ9V3wersNyew/4Zg6n2HpBWxnZEH8Fig0BgyAe3P
         l/mkqXHvHy2HafdcB+pS/lpQwy2tUzy8ogYRh5FB5/6ELMSqcZggehCrMEXLV2O9PIHl
         L3mg==
X-Received: by 10.13.192.132 with SMTP id b126mr21955250ywd.163.1437274231578;
 Sat, 18 Jul 2015 19:50:31 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 19:50:31 -0700 (PDT)
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: 0F9_SWRtxWDDmk5vpbtvntf3z6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274192>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I haven't been following the discussion of this feature on the mailing
> list, so I apologize if these changes overlap with any in-flight
> patches, and these changes should definitely be checked over by
> somebody more familiar with the feature. These patches mostly fix what
> seem like inconsistencies in the documentation. The last patch
> contains some wordsmithing. Feel free to squash them together if you
> prefer.

Thanks for the patches. The changes mostly look fine, but see my
responses to the individual patches for some comments.
