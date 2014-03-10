From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 12:44:23 +0100
Message-ID: <CALKQrgfczpUU6Lh+hf867UOYUge2qsBTBTknwAk2pvRF6=xi4A@mail.gmail.com>
References: <531D9B50.5030404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMydF-0003E4-VX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 12:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbaCJLoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 07:44:30 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:53410 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaCJLo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 07:44:29 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WMyd9-0007TX-US
	for git@vger.kernel.org; Mon, 10 Mar 2014 12:44:27 +0100
Received: from mail-pd0-f169.google.com ([209.85.192.169])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WMyd9-0008bo-LU
	for git@vger.kernel.org; Mon, 10 Mar 2014 12:44:27 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so6993982pdb.28
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 04:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tmmBhnrtxmb2GsFjDfWrBts1w0gTI6QsMdMLPU1t0F8=;
        b=nB8f3A9vE5/1ynkO27RHk7EEZfrEPMTtPcdTzEB/t7AGbg3YXe66OdyNMXSFstguC1
         xoWmVSgharTX5l2Lvxf5aVKbUZUGjWmm3vVL3dCO+H6b70wTOMgetZcKUziGqoyIOOmK
         epUvlx43IP1CDgHJ4VrIcllYv0e20ezyTCiys4t32C0aBbwgDll+nZwHk+yQojyY8U9h
         Nfmglk6c0g1hamqry9+rhTNB+RLHWPD8Nq/rBkO5thkOcZ90RGmI61zKIW6JNJ2HEMzw
         rVeCJ2YGU36ZyJJKwQsQXwH+m/KVvZzdRNl+h4dpfX9hCofwnb3KSHnbtV84GZODKcMi
         x6Nw==
X-Received: by 10.68.129.5 with SMTP id ns5mr7103267pbb.147.1394451863683;
 Mon, 10 Mar 2014 04:44:23 -0700 (PDT)
Received: by 10.70.48.228 with HTTP; Mon, 10 Mar 2014 04:44:23 -0700 (PDT)
In-Reply-To: <531D9B50.5030404@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243729>

On Mon, Mar 10, 2014 at 12:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I have started working on pluggable ref backends.  In this email I
> would like to share my plans and solicit feedback.

No comments or useful feedback yet, except that I enthusiastically
approve of the objective and the plan you have for how to get there.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
