From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Git + SFC Status Update
Date: Tue, 14 Apr 2015 15:00:25 -0400
Message-ID: <CAD0k6qT9Sj4VQ+4PKvXmwwfuZHFoGXNmAMGxTiorx81E0U11xg@mail.gmail.com>
References: <20150413115613.GA4589@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:00:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi64q-00073j-97
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 21:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbbDNTAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 15:00:48 -0400
Received: from mail-vn0-f51.google.com ([209.85.216.51]:33324 "EHLO
	mail-vn0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbbDNTAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 15:00:46 -0400
Received: by vnbf1 with SMTP id f1so7013076vnb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/v1mxxNBWnLtj0WD0miS3DS+Xo4A2PeryoCV038Kz2I=;
        b=MG8ZG4pBlPeSQZ8f06u1BNIMQipv+4WoaEUHsXbdxkOE69Q4f4kOtMygy+ayWIuV6a
         uHLvT9iKyMBJi+9B0Z2A3YmVSao2tqV+rrHScYwiMzZyslKycsIz3JJAzomFMiyDTFIf
         QMZM5H4+GhxuOp3Su6WEnlfRs9eodPjfgq3BCTfFj8Rlmp7P3zb3b3Rn4hTSfmqn+EfM
         QaBvdhcb7tYPN526L+zxb1d2y4Jz3GJihNVCvy3+Vxdv0oH4cgf4GQXNVn6aid++w9Cs
         ctbItXcryHYLGoqVLWJwylC5f0dpQlO8woawjpK1deHYQthNSZndyLBTq284wRiwdY2N
         peog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/v1mxxNBWnLtj0WD0miS3DS+Xo4A2PeryoCV038Kz2I=;
        b=byRg/82ss83eSBFBN6AWSECMmLuMSKJ+dauhlG3rCE2PZYugcuFNwaKkmDBxpfZVx8
         GVPXBGi3xmypVH11zsqG5/ARXW4d7oADAozh4JxUtgF6G7Yv/KqE52clvCHR8srrEqAT
         Mfmz0podc/8sCz8+u4ddr6ECwQrfq1wWii9xV4yyuiRZIpLlIVun9cBV5aV95WCKOvJG
         DfiFGZ5uuVnjNw+0ZYghHVdsq/qxM8ZRVhYmUWmFwptmchNhkCndQEBqgVF0Mn4Dea4M
         DtFY3MPIPlA3ynVIyZUEdsDDtDTQOKe72oEJuECwTTxt4hK8cfV7EAlXV1QOjUQcX/Gq
         wh3w==
X-Gm-Message-State: ALoCoQldqYWdazVfosdBvuQ1lPpuADmCTZnH+OI6+ElH9IJHhGTo3WpbQMJn3pfGU0u5vj5VPZwB
X-Received: by 10.52.151.227 with SMTP id ut3mr26477148vdb.85.1429038045832;
 Tue, 14 Apr 2015 12:00:45 -0700 (PDT)
Received: by 10.52.126.16 with HTTP; Tue, 14 Apr 2015 12:00:25 -0700 (PDT)
In-Reply-To: <20150413115613.GA4589@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267157>

On Mon, Apr 13, 2015 at 7:56 AM, Jeff King <peff@peff.net> wrote:
> # Money: How much do we have?
>
>  - $19,059.25 (USD)
>
> // Disclaimer: this is not necessarily up-to-the-minute, as
> // SFC's reports to us sometimes lag a bit. And also because
> // I am fairly inexperienced using the `ledger` program, so
> // it's possible I've misinterpreted the results. However, we
> // shouldn't have any serious outstanding expenses, so this
> // is close to correct.

If I recall correctly, Scott said onstage that some/all of the
conference proceeds would be going directly into this fund. So this
might need to be revised upward by 50-100% sometime soon :)
