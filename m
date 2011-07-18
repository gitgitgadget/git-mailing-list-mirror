From: gaoyong pan <pan.gaoyong@gmail.com>
Subject: Re: git sparse checkout repo size
Date: Mon, 18 Jul 2011 19:54:25 +0800
Message-ID: <CALf5Ac3DcoB+Psgwys6NNOmTcyGmKj5dKhR7K8ardF6MsCCDwA@mail.gmail.com>
References: <CALf5Ac223mASO+KGYa3nqB+3eajvRS4QueGT5on6G5kYqhODQQ@mail.gmail.com>
	<CALf5Ac2A4XTfkZraVra2sSGJZJ31bTyfmgHZWjptJNgQtXyH7Q@mail.gmail.com>
	<CACsJy8C=LdcaQbc46ssc5=tTXyA-U4N4FAsqjnPyEqwYZuO4LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 13:54:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QimPA-0002JK-7q
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 13:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab1GRLy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 07:54:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44353 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399Ab1GRLy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 07:54:26 -0400
Received: by wyg8 with SMTP id 8so2014532wyg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7sgNSJuSJZYU5AIJAF8IJxl67ZcapblwhYypexTgJ1Q=;
        b=K5HlwnTNHcHaxzGfR6DSR5f3iLZijm0u3+dLqSaNDRFDPO2gGgvRmzqqGrtqljxWuy
         pxwoXJDD6H0Z1yXpqIIjKKhn19oUO/GqsXts+KkLw9qJLO26jsp3Ru8vqhZQb5mwAxtG
         O/IGeUFk6XKqouTl2TBc1MvsaUOEWGFOwQkDc=
Received: by 10.216.235.83 with SMTP id t61mr2882559weq.46.1310990065140; Mon,
 18 Jul 2011 04:54:25 -0700 (PDT)
Received: by 10.216.175.130 with HTTP; Mon, 18 Jul 2011 04:54:25 -0700 (PDT)
In-Reply-To: <CACsJy8C=LdcaQbc46ssc5=tTXyA-U4N4FAsqjnPyEqwYZuO4LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177371>

2011/7/18 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> The ideal
> solution would be narrow/sparse clone where you only fetch history of
> your two files (plus necessary trees and commits) but that won't come
> this year.
> --
> Duy
>

I need to push back so sparse clone is the best solution, it must be
very difficult to implement so it won't be released in this year?

-- 
Best Regards
Linux user #384184
@ http://counter.li.org/
