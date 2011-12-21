From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Big Mess--How to use Git to resolve
Date: Wed, 21 Dec 2011 17:06:39 -0600
Message-ID: <4EF2667F.9020600@gmail.com>
References: <1324125130643-7103964.post@n2.nabble.com> <86iplf2oy5.fsf@red.stonehenge.com> <1324147247781-7104493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hs_glw <greg@hra.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 00:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdVFJ-0006rE-G7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 00:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab1LUXGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 18:06:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58694 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab1LUXGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 18:06:44 -0500
Received: by ggdk6 with SMTP id k6so5911606ggd.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tPM3ycm4fs87Vbqiwz9wCtO3Sl7pMSdLN3ZCmQjeGmQ=;
        b=QYDCBgYCODGoRLtNKwxpNwRYN5kC+9vZEJosTsFV3bzoqhbBOmGSdwobnIH57oSgyX
         JP0+k6x82bE2eyl864LYDY+YqpZmj59Ms1FYQn1fNVYSKnFWDT1cxn85sYTfPEWxR9d7
         6ymJHZ017BISYU8Tot456BAPmPm2GmgbYQPKg=
Received: by 10.100.229.2 with SMTP id b2mr3701493anh.80.1324508803852;
        Wed, 21 Dec 2011 15:06:43 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id o50sm11422308yhl.9.2011.12.21.15.06.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Dec 2011 15:06:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1324147247781-7104493.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187590>

On 12/17/2011 12:40 PM, hs_glw wrote:
> Randal, thank you for the comprehensive answer.

The technique Randal described sounds like the 'vendor code drop' method 
described in the git-rm manpage.  There you will find detailed 
instructions on the best way to 'erase' the previous version and drop in 
a tarball of the 'newer' version.

Hope this helps.

v/r,
neal
