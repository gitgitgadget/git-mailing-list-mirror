From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: [PATCH 09/13] Improve section "Merge multiple trees"
Date: Sun, 25 Aug 2013 13:10:13 -0700
Message-ID: <20130825201013.GB2752@elie.Belkin>
References: <20130825052327.GK2882@elie.Belkin>
 <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1473018875.1091101.1377329545934.JavaMail.ngmail@webmail08.arcor-online.net>
 <2127851205.483802.1377432379441.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 22:10:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDgdj-0007Ln-2w
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 22:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab3HYUKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 16:10:19 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56960 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab3HYUKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 16:10:18 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2633374pdj.30
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tr9IQ1Ut2qC4JOUsv+VEfYLfy9gYb64L6NdaGAp3NDA=;
        b=zl2WCc4SwyGpQicHBna5QlfkxLm7BRzjwDz/XPiJa0rwSCEYS2GnCC5vRb8ZlpHDaG
         UjXu79BSGEWa/879CdICFtqUrtx4PKNjv7nre5uqSQJ6EfbzzRFHdQkV8CkwHZd1nBxN
         Adl7gUOzYG3df0LnFUolKhwnd44IstKPaTGqp2P276n+e8r/5X4A/SwShyMP01yWCC+O
         IdlJQZMg5J81jyk1WLpIMHXHobAz2a4JZQO7ssS/5mH5BYNFXIJlmrg8uC7YmZ9A7955
         dSnJ33Gqa8IqnkaeZ3bvC3NpsGVORKvmSl469hz4cSQnQ1tom5JWH9tA+ZtV+2Xa4TPR
         IosA==
X-Received: by 10.68.221.233 with SMTP id qh9mr11517981pbc.103.1377461418197;
        Sun, 25 Aug 2013 13:10:18 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id oj6sm15361607pab.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 25 Aug 2013 13:10:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2127851205.483802.1377432379441.JavaMail.ngmail@webmail16.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232966>

Thomas Ackermann wrote:

>> Maybe the intent is
>>
>> 	Git can help you perform a three-way merge, which can in turn be
[...]
> If you don't mind I will use your text

No problem.
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
