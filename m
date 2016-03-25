From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] Proposal
Date: Fri, 25 Mar 2016 15:12:01 +0800
Message-ID: <CAKqreuzXezkFdp2zvAL3oF0G5GxLS=MdAeu18BZicBriwbbAKQ@mail.gmail.com>
References: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
	<CAKqreuwFbObbMf_Lc6Lc01zrdGZf2qCTwgeD+db_CwebS_iDrg@mail.gmail.com>
	<CAFZEwPOm0SvvsH_mzp+G6Me6zKU2GVk6AxMJ7iJOYuEJ7iJV2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 08:12:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLuj-0008FY-13
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 08:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcCYHME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 03:12:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34112 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcCYHMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 03:12:03 -0400
Received: by mail-ob0-f177.google.com with SMTP id kf9so48658047obc.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ifw2UEoe4mN8eE0ZseQq9l8Ey82d+L1wTpowJodLjFs=;
        b=F5ReHSB224piF9S6j5H1Z42D3OmGITWXEYJf1DrZA78QcnJyk4Oj2QMHPFoIEWVsMT
         y2e7Kiy/VWhjwqQZClNuXvC7MSzWhk9mcL2zJBuQfh6z4Rk0GQXgGlfQ8AWVvvrvxHR3
         SLg8M66cV3j+uTLgFg1RprKfRzmmiHKMNECZ1kCChCB8fKTYagM/XjNAs19C81YZKgNq
         4LUG9rCpsErcmhhIQEP8FARQb22o74O4vF6BDZwavqOhjXYfvRVfhnLC6lLaek3zCW3G
         UdxfRNtM98uCQI/M/VGCUvD6sXvNv7E7SRyq9ZH0mlsh5I1VIUoadwkomlMYUaAEkQR4
         DVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ifw2UEoe4mN8eE0ZseQq9l8Ey82d+L1wTpowJodLjFs=;
        b=JR+ZX1Sbe+Kq8ngy2n6pi3gG1fgFRJgcNX1JpwZAFcpm32rqzAfYdF2pM2qHEok1vA
         Namzn4Lnbyule51ld6U6icblfTCysdYNlJ2y+1RjLCgAYMwDfqcDrN0VVX0IJ9YUOoJ4
         ndsmSpl61gVba5MR327D1K9O0ElR6wOwizKx0vp3XJjckBfWZVb2gBSovdnouaUidnsI
         I3sl1YVw5TdFhkGs4RU4pPdSPOohrsKF7twqp885XFjgO5prQSYflko1tiXbYmDvAjtG
         eVfJ0IM8oWcq1A1YayD/PApXd9MR4JPo71IaVnSsmeEr4CTBWroDYhH3i6uqlI6+VrsX
         BuAw==
X-Gm-Message-State: AD7BkJJ1vWIiqxvcZ5J5oteBOajHfa4lc39PChVrB8DFTsND4lo+vwcbfThGiBo7MYOP34/3nOzwnyf9vw49mw==
X-Received: by 10.60.147.228 with SMTP id tn4mr6099961oeb.33.1458889921558;
 Fri, 25 Mar 2016 00:12:01 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 00:12:01 -0700 (PDT)
In-Reply-To: <CAFZEwPOm0SvvsH_mzp+G6Me6zKU2GVk6AxMJ7iJOYuEJ7iJV2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289857>

Well, I should have done some search before ask.
