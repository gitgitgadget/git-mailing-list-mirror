From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/16] make usage text consistent in git commands
Date: Sat, 23 Feb 2013 16:29:39 -0800
Message-ID: <20130224002939.GH3222@elie.Belkin>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PTl-0004qq-QO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759400Ab3BXA3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:29:45 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41719 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759302Ab3BXA3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:29:44 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so1117068pab.22
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=klwxdaN/VTribvrE74W4bVRPh0v/9iGPpNcQxe/A6V8=;
        b=s44FlLO7fJOxHkXWytY7Bxp34HN06uU/vwyiqzC1yDosvxy6ZWurLY6hNoE5hrMUH9
         JvHDsSfTccZOrUvkHkRY8ywFkc7p4jAk03gVY+kQ8kJtQlH2jbhUovSlkWmVM93+gTLN
         BHk2b2omGk6iynGGBmGLG8InIeyPS0bEnapNhDr3rtTGntzI9POKHhwvlZomg6UY2ISc
         vQsVDXg/lTE7769mwhOEmgcYAbweiXNws20nrYW6iCBzWyCND45osNxD4Eu18x4u9neD
         JrSRjSmFgCS20dB5Zhht8EVy5OHO0JzhHR6dzYJwxN0tPF9t9u1DSanG9gGNRosIj+5E
         1SnQ==
X-Received: by 10.68.219.195 with SMTP id pq3mr10837216pbc.184.1361665784365;
        Sat, 23 Feb 2013 16:29:44 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id x2sm8163791paw.8.2013.02.23.16.29.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:29:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361665254-42866-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216956>

David Aguilar wrote:

>   git-sh-setup: make usage text consistent
>   git-svn: make usage text consistent
>   git-relink: make usage text consistent
[...]

Micronit: titles like

	git-relink: use a lowercase "usage:" string

would make the effect of these patches easier to see in the
shortlog.

With or without that change, all of these except patches 11 and 12 are
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I have no opinion about patches 11 and 12. :)

Thanks,
Jonathan
