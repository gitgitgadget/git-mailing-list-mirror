From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Fri, 11 Dec 2015 11:58:47 -0800
Message-ID: <CA+P7+xp_4Mm+Y=jxOnva055ZWL05mVE3eWUyanzz8t4GU-bdsg@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
 <20151124224709.GA13691@sigill.intra.peff.net> <20151124234206.GA31949@sigill.intra.peff.net>
 <xmqqr3isepit.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:59:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7TqX-000642-3w
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbbLKT7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:59:10 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33178 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbLKT7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:59:07 -0500
Received: by iouu10 with SMTP id u10so140475176iou.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2KIa58okau5q/Hdm0mfpSwBT/jgQIxC6YpnSF35zR7w=;
        b=MLslPSCcBqB2oi+nq+ftq4jAB1Gma6HWseE++CNIpXivHAM2r/vnvBvS1BVhOlchAj
         5G2cO22qJQDw6IagSvlnn6pM/Mk2B75J2z3ugi7WLDP1e443cy/talmmkCJqbU+KFHOB
         1mrJfPkRifKet7trCU+NRgsb2MCaPPgOpoagRcPs8aOkKazyBIdQrTYYZJnAQ4qvzijS
         j6w6EKVk6lMBRzoal8twjtrfqeUubnKHj50iVOW1lTpFZ9uaWImdh8p7tWO98Tqst0Wk
         StGwL19QL0S0wyr5M23/J3mbhlmLS1hLSXfeAvKsH6/rCBggVR3cZgoB0/I6v2iaKoB8
         98Jw==
X-Received: by 10.107.136.39 with SMTP id k39mr22437377iod.0.1449863946886;
 Fri, 11 Dec 2015 11:59:06 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Fri, 11 Dec 2015 11:58:47 -0800 (PST)
In-Reply-To: <xmqqr3isepit.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282276>

On Fri, Dec 11, 2015 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I'll discard the topic for now, expecting the resurrection sometime
> later.
>

Hi,

Yes I fully intend to work this against master once I have some time
again. It may be a few weeks as I am extra busy for the holidays, and
the next posting will be fresh on the tip of the future-master :)

Regards,
Jake
