From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how to patch git documentation
Date: Fri, 09 Mar 2012 17:11:08 -0600
Message-ID: <4F5A8E0C.20404@gmail.com>
References: <jjbqe9$8l3$1@dough.gmane.org> <7v1up2bikm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:11:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68xw-0006NX-LP
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 00:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2CIXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 18:11:12 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57437 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2CIXLL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 18:11:11 -0500
Received: by yhmm54 with SMTP id m54so1279604yhm.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=40fMlIU6PMG+sNFgzj9LKk/NgIlO0QEq6hyhoSwegBg=;
        b=y/sxXoIHM6aacLixGtv9UEo+PvCcrKtpiPIj/szFOjdAPtZI0ac3FIQ8Kx1wPA1EFE
         SZbpxSY9nl+oHWC23z7ceu65m5EULyrZ4pYbKi7/9GGKiDym3ndtuoPm6gD3BMVWzwZB
         T8DCpL4iHPKXh1qfwP7IHVEySNLAuDskzhtkYXJz5Sv/amB7tQjBSnqnkzUV1kpcSQHB
         qY4Y85Z0XbwcVhxr6Ekt+ETvFXUFMmvxUQ0r2pgrS1u6jEXZvdP13uvQkp5iDqGuF84o
         1PmHeAU9lQ4/9rgGITRnw6QS1yvdvFmYOAky4OrjDaTRbMOl1QfOrYIXQB0Wb1/lDlDC
         /iwA==
Received: by 10.236.191.105 with SMTP id f69mr4890777yhn.23.1331334670372;
        Fri, 09 Mar 2012 15:11:10 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p41sm17713453yhj.14.2012.03.09.15.11.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 15:11:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7v1up2bikm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192757>

On 3/8/2012 8:43 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> What language are the git documentation *.txt files written in?
> Mixture of Pidgin English and a bit of AsciiDoc ;-).
>
>
Does someone have documentation on how to test the AsciiDoc changes of 
their Documentation/ patches?  This tester I found doesn't work right 
because it not only shows my asciidoc changes misformatted in html, but 
it also shows the original working asciidoc code from git.git as being 
misformatted in html :  http://andrewk.webfactional.com/asciidoc.php

v/r,
neal
