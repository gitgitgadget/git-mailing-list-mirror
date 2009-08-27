From: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
Subject: Re: bundles with multiple branches
Date: Thu, 27 Aug 2009 22:03:41 +0200
Message-ID: <30e395780908271303y3cff747dpce482379fd0c54cf@mail.gmail.com>
References: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
	 <c376da900908231352o5c5746c0h9e39b80adede66e8@mail.gmail.com>
	 <30e395780908231404k7240dbacu5c258d9816e35dd7@mail.gmail.com>
	 <c376da900908241442t385d492cm6925fd2d8abad848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MglCJ-0000kI-Os
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbZH0UDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZH0UDl
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:03:41 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64558 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZH0UDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:03:40 -0400
Received: by bwz19 with SMTP id 19so1208800bwz.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qVGx366qWCzuFbTyD7q/7W0Ka53wbfx7Q7plmaAT1UQ=;
        b=l0y81PtTjBKeushdCMFglDqOitepUEba1py6AWosBy1OImUUgUl1aDisRqLFJUBet3
         8oiLk32n8+PvggfG2x6xY1EYQCF5FBIRX8y0LrSEn+dviOYbKoIoE9MSxaypAmfhPmVA
         HLoJt9VzvplzdJmuwkJK1bulcOJXAppt31/Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vm7JbVc4CrG9MvyfManREj6dDnYoo8ZFbraYqv59jn4LpQ6QwCSGHG9OPcPffNU2Rz
         WdU+MyCtzV7cTd65tUUMt7z07CHUtHZjjeujgK8pWGwlMfSU/Av1NWG5GWxegu2gp3W1
         p6LB2Gj1if6QvgC1n/70c3U5sKkmO5khx8yZ4=
Received: by 10.223.4.150 with SMTP id 22mr132835far.38.1251403421269; Thu, 27 
	Aug 2009 13:03:41 -0700 (PDT)
In-Reply-To: <c376da900908241442t385d492cm6925fd2d8abad848@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127204>

2009/8/24 Adam Brewster <adambrewster@gmail.com>:
>> fatal: '/media/cdrom': unable to chdir or not a git archive
>> fatal: The remote end hung up unexpectedly
>>
>
> Sorry, that's supposed to be /media/cdrom/name-of-bundle

Thanks.
