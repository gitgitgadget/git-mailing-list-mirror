From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 14:17:32 -0400
Message-ID: <CACPiFCLOGc-6M-boSonGHuxKR6OaoosoEiybc=xfuT73C7dS6w@mail.gmail.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com> <53725eeb1cab5_7774d392f87c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:17:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHH3-0004RN-8t
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbaEMSRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:17:54 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63692 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaEMSRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:17:53 -0400
Received: by mail-vc0-f174.google.com with SMTP id lh14so975693vcb.5
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WqGIlA9bHuEm2LGt3p35rt9YXunuCoJmpqAHboHeFO4=;
        b=hfRuVWFr7tSno42ZDDRgsQKHBcDu8wuGFfuuUFoKO6WJWtWW7M/sy/QB9A4oiwYeTq
         0oNVWeaTFknP3Lo95NJatqwllm6Fqy9Y8zdLLJg8GWKCQiR+xufVYTFFafT25Y6YhyVX
         mzohHgJnTg0638iV+UdkxqM7fNkKASBY0qf2NyRp15krNxdmlExWeh9gR3/jzqKUEdXM
         arV1soMfUPMEJXgWzPdAQ1F01rQM0QJGhhxdZiKAbEr4QNYiPPsh2gJiBboUADB99uZy
         6A8JKCB/t13XmBH2bOFtbsmPcInHrEIorpm49UoZdiZDPcTnSpPP06NqfcUrkF/USJPf
         npSw==
X-Received: by 10.52.65.165 with SMTP id y5mr1511541vds.51.1400005072566; Tue,
 13 May 2014 11:17:52 -0700 (PDT)
Received: by 10.220.183.138 with HTTP; Tue, 13 May 2014 11:17:32 -0700 (PDT)
In-Reply-To: <53725eeb1cab5_7774d392f87c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248797>

On Tue, May 13, 2014 at 2:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This tool doesn't even work anyway.

It doesn't? Bug report / more info please?

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
