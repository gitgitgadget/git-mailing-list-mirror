From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 04:03:13 -0500
Message-ID: <5375d4516e48e_1a1b8d330874@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <CAHVLzc=FcT6BcwX=kx7WKNqod4S0ePmvh5p+sgnQfWTPQ=7yTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 16 11:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlEDf-0000KV-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 11:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbaEPJOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 05:14:18 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60755 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaEPJOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 05:14:15 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so2678608oag.13
        for <git@vger.kernel.org>; Fri, 16 May 2014 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=oTkrP1/6YaLHNzoSPFTGz0UrME4Pzni/L3Z/pK0Imb8=;
        b=o/mxM3hS+8CfZQgfbpf+NNKLzSt4D2tndvVp4WEoSLXTD/0d6lQiy/INT3EeHqjTem
         SQZhbNybbMbXkGZ1tH7jN3z+LPfaAjoLFAHW+/A1Ai7AQeToA0oM9bzEa8uSptqGCkXb
         V0lhaFFVDUhTIvBJfxI9tUGl3C4XLPCqmY9JPSOWWhdaL2s9NV9n41toOQIx7IwHRbyh
         MqnVTYu2s3p0mn+f441DZ1Lotfqt3XrdQkd66AC7ZLbZs1sZjWtti+gVfm8PVC5i8b25
         9l3E82TrxWWSudBG5bmF8r/4DTnT2+yM600uWZCwd4x3zq8WBWQtrOHfH9ztPRVyb/Cw
         AoTA==
X-Received: by 10.60.41.104 with SMTP id e8mr15876450oel.18.1400231655388;
        Fri, 16 May 2014 02:14:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm13899606obm.2.2014.05.16.02.14.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 02:14:14 -0700 (PDT)
In-Reply-To: <CAHVLzc=FcT6BcwX=kx7WKNqod4S0ePmvh5p+sgnQfWTPQ=7yTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249285>

Paolo Ciarrocchi wrote:
> On Fri, May 16, 2014 at 10:41 AM, Jeff King <peff@peff.net> wrote:
> > But that being said, this is Felipe's code. While we have a legal right
> > to distribute it in v2.0, if he would really prefer it out for v2.0, I
> > would respect that.
> 
> My understanding is that Felipe would prefer to keep it _in_ the git.git
> repository and eventually get it included in the core.

That is correct.

-- 
Felipe Contreras
