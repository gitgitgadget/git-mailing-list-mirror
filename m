From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Sun, 29 Jan 2012 21:29:13 -0600
Message-ID: <20120130032913.GC10618@burratino>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
 <20120130025014.GA15944@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 04:29:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrhvo-0007zg-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 04:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab2A3D3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 22:29:20 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63810 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2A3D3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 22:29:19 -0500
Received: by ghrr11 with SMTP id r11so1569500ghr.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 19:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qJn7ZvVx38GVUQRHrZWaO1ytSR/7/0O4axbKoKzBfFo=;
        b=a64PRZUX9H2QcjhBt+VFsVDNfbtEQNCBbhxMvAAlpJ63C83iaiYqI0aZxiJ769Oufz
         MTwPHvcSFx38gk2bouUMnjO/bCtjYbaAYNJ7mqxmzwOOGvRViTFNmOTIrA18H1bFsJKI
         l52FEuCVUPlHwcOJewKabWcUoIC8RjMGYjPWY=
Received: by 10.236.114.199 with SMTP id c47mr23162158yhh.81.1327894159252;
        Sun, 29 Jan 2012 19:29:19 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h20sm42585775ang.7.2012.01.29.19.29.17
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 19:29:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120130025014.GA15944@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189318>

Jonathan Nieder wrote:

> What codebase does this apply to?  My copy of git-completion.bash
> contains a number of calls to __git_shopt

Ah, now I get it.  This would have been easier to understand if
squashed in with patch 2/3.

And it certainly looks like a good change, yes. :)

Thanks for explaining,
Jonathan
