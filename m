From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: gittogether session notes
Date: Fri, 29 Oct 2010 14:11:51 -0400
Message-ID: <4CCB0E67.60605@gmail.com>
References: <20101029180530.GA18997@sigill.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 20:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBtQn-0008C4-BK
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 20:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0J2SL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 14:11:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56577 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0J2SL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 14:11:56 -0400
Received: by gyg4 with SMTP id 4so2154758gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6m8L2f4oBE8GYZxBOWEjTBOJL8lKMlVgfYPrrtnXPwI=;
        b=d/+RHjWegCKo/6qpaZEX7+6ZDSVb+f0nXnqp8cRFuOA5c5tdcFU4NWZY++90m6ELny
         W6rRp1ew8Af3umMdZBd3BP4oUXyUeqVMDsGm2uRJQ3IXmDKKHdOYhM/vizNt7t56TPd0
         j89GuAIJyF0ksn9opsjkqfGwAlztia1Sl8f2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=K7E4WJIr8lt2TAwJUMgd7Ci59Vo3IQc1cKunRq0Rdqz2Z+BfG7iy7HvCU+XAGUjdNF
         t6Kqr8GzW9hTjK53Cd2kN2KD0PJsOQmrfUV5vxJQCdsLmUIhlhM68+ROJK5khKtESSTz
         NE86TpJRv1L2PdQXh5aadMsZ8XITYADZgzNGg=
Received: by 10.42.228.2 with SMTP id jc2mr9675072icb.199.1288375915094;
        Fri, 29 Oct 2010 11:11:55 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id v20sm1345020vbw.9.2010.10.29.11.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 11:11:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
In-Reply-To: <20101029180530.GA18997@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160351>

On 10/29/2010 02:05 PM, Jeff King wrote:
> For anyone interested, session notes from GitTogether '10 are here:
>
>    https://git.wiki.kernel.org/index.php/GitTogether10#Session_notes
>
> They are mostly rough transcriptions of the talks by a few volunteers,
> along with slides from some of the speakers.  Some of it may be
> incomplete or confusing, but I'm sure many of the speakers would be
> happy to carry discussion onto the list if emailed.

Did the GitHub folks do the their Git scalability presentation? I was 
hoping to see notes and/or slides from that.
