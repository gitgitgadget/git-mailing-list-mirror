From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 15:06:01 +0200
Message-ID: <555F29B9.1040805@gmail.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 15:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvmeS-0001kz-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbbEVNGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:06:08 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34478 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbbEVNGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:06:04 -0400
Received: by wghq2 with SMTP id q2so17308181wgh.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=059PVGIjFPM7PWZZgLTDlp9o+4nja99T4kn2vlZV+NE=;
        b=dd8OaA8jwg88VmWfDbdKn1ofPPTOyd/SnsyfoW5XAWKJNzTbaN9QMTy86IEjFgSgd8
         AVwabqxhQDeCrZurZkuW2Xqg+h/XMbkg5eumF4F3zA6NdAE5gmCGn/5uYnldB2Kghvbl
         KruK00o8EayvKBkoDgvuvqpc9D4awKBWJA9V4bfXpxc92uxdhNsN7p9Z4COpfsvnIV8a
         Y3kEhexf0PWPhbMfgx+kTxofy/bynlXnTKHqzhaJgt2o0WLLDsjcmlTCXA0+vBN8Kf5z
         6yF5t2/oMh/fhKOzjqKS8yxJCB3MNViY4uVv22Kzpk3rZWNox0BMIa78/qYKe+lF48jy
         0xHQ==
X-Received: by 10.180.98.1 with SMTP id ee1mr7576126wib.86.1432299963759;
        Fri, 22 May 2015 06:06:03 -0700 (PDT)
Received: from [10.223.42.70] ([131.228.216.128])
        by mx.google.com with ESMTPSA id gi14sm3070454wjc.42.2015.05.22.06.06.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 06:06:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269709>

On 5/22/2015 10:33, Roberto Tyley wrote:

> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:
>
> https://submitgit.herokuapp.com/

That's fantastic! Me being the one who brought up that topic at the Git 
Merge contributor's summit, I can say this sounds *very* much like the 
tool I've envisioned. Many thanks for that, I'll be sure to give it a 
try as soon as I can.

Best regards,
Sebastian
