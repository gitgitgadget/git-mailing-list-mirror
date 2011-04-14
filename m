From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 21:59:43 -0700
Message-ID: <9D7CA8EE-F170-4BBB-80B8-B342E7D1709A@gmail.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com> <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com> <4DA654D4.5040104@medialab.com> <4DA65BB6.5080909@medialab.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Searles <daniel.paul.searles@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Chris Perkins <cperkins@medialab.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 06:59:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAEep-0006dP-7F
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 06:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab1DNE7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 00:59:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40960 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1DNE7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 00:59:47 -0400
Received: by iyb14 with SMTP id 14so1135497iyb.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 21:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=bXq4SjLzi+Pbw/bHeyGaASj+bQ/rh+cdXpRyVioi3A0=;
        b=eW2RypcOlpUDxJpEwBEwuJuVLIXd3731cPPZ+jpfLbloT+H0xVF5OarxnEssWWH2+h
         BA7KzU+X6eEKXA6TDa7CWbm57syF3maA9cFJxHxBpEhZ+j9/H6PjwSm1JmYZjPqEBlZv
         DKDug3+rclnXvsu2WM0J4QWd4TtRpVRZjFX7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=amsag2ov5nBeVqZ8pYQm7VWKJuHdSLoN0n+Dd7t916AI7LuwRmvQuNUpBOarTUYYWh
         vExidIy8CqJiu/F6SfXY3u9o9b6r+glsShsZUADZFIrdz7aUWnNq2hTEu1fxfDSrbaJE
         FwRyQRN2AXYVKwv6xVfTbblAwfXGHEKPfF08s=
Received: by 10.42.147.196 with SMTP id o4mr477753icv.183.1302757187269;
        Wed, 13 Apr 2011 21:59:47 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id xn10sm871576icb.4.2011.04.13.21.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 21:59:46 -0700 (PDT)
In-Reply-To: <4DA65BB6.5080909@medialab.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171504>

On Apr 13, 2011, at 7:28 PM, Chris Perkins wrote:

> You can't make commercial works based on GPL licensed software.   
> Without
> Git there is no Gitbox. End of story.
>
> I'm not a lawyer, were I then perhaps I'd know solidly one way or  
> other.

Or, you could consult a lawyer.  Or you could see what Git authors and/ 
or the FSF think about it.

> But I will add this, some on our team would very much like to
> incorporate Git into one of our own upcoming commercial products.

I imagine some of your users would like that as well.

> Code-wise in the same manner as Gitbox has done.

As well as ProjectBuilder/Xcode.  The same company that released their  
Objective-C compiler front end to GCC under the GPL, demonstrating  
Steve Jobs' willingness to comply with RMS' interpretation of the GPL,  
also created their own proprietary GUI front end to GCC tools.   
ProjectBuilder/Xcode has existed for over two decades, and to my  
knowledge no objection has been lodged.  Clearly, there is a critical  
difference between linking and invoking.

> But we aren't going to
> do this, because the GPL license for Git clearly states that we  
> cannot.

Then you may lose some of your users to competitors who more  
accurately interpret the GPL and are clear what rights they've been  
granted.

Josh
