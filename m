From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 16:21:28 -0600
Message-ID: <20120214222128.GA24544@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
 <20120214211552.GA9651@burratino>
 <CAMP44s1mV2cE=R49qYSLd8eZPhCpRx0hRnnG_-K3iBxp_YQEpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQkt-0007us-6g
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761297Ab2BNWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:21:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47517 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335Ab2BNWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:21:42 -0500
Received: by iacb35 with SMTP id b35so495786iac.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VU5oxkAIZsaMP+wwGFeBlt0mKd97F11DDihupNs0HG0=;
        b=heh8PJbGy9Q4AdD0kNfLrG6sSsnVowL1S+I3foEIfwNMaRHY+4zWKxDjgT9dsgAM4m
         Klag49MBT/nQjb+88hx0GzXJxgaI4hVBTGdhgszqNxnn7mFGZBOiP12B4FSUPKGUL0Sd
         KRJ5vr+f49Hvdd2g8UcEu7+MFmHyAMvqJGb9I=
Received: by 10.42.161.73 with SMTP id s9mr30574492icx.16.1329258101737;
        Tue, 14 Feb 2012 14:21:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id al9sm1122665igc.5.2012.02.14.14.21.40
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:21:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1mV2cE=R49qYSLd8eZPhCpRx0hRnnG_-K3iBxp_YQEpQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190779>

Felipe Contreras wrote:

> The difference of opinion is that I consider the patch already good
> enough (adding the comments from Junio).

Ok, I can understand where you're coming from there.

Now I have offered some suggestions for improving some of your
patches.  Applying these suggestions would be effortless, since I sent
them in patch form.  What is your response?  You send a point-by-point
rebuttal explaining how each detail of my suggestions is bad, bad,
bad, and then resend the original with comparatively small changes.

Can you see how this might indicate a stronger difference of opinion
than you have mentioned?  And how a reviewer might make the mistake of
thinking his comments were unwelcome after such an experience?
