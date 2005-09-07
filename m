From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Docs for git-checkout-script.
Date: Wed, 07 Sep 2005 17:34:27 -0400
Message-ID: <431F5CE3.4000608@gmail.com>
References: <431F58DE.2000904@gmail.com> <7v3bog6082.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:36:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED7Yw-0006jn-IE
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 23:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVIGVeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 17:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVIGVeb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 17:34:31 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:41816 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932448AbVIGVea (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 17:34:30 -0400
Received: by wproxy.gmail.com with SMTP id 57so1195927wri
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 14:34:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kooo1sFZCkqtygJNKNtUebxTEySCEVZ/5oGfH9ONBbWY4UyKdOqB1osKEZxNvO03MjC+nKE+qFWGfKKN7XTdg+HAlo1Gs+OFziW9N35GOOSivsYOLsB3SoI7FDGcUq3zbpR8JVYHm0taWFjRIsg7v/FsbAxRn3kBp6WIm1euSCg=
Received: by 10.54.33.26 with SMTP id g26mr5465554wrg;
        Wed, 07 Sep 2005 14:34:29 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.98])
        by mx.gmail.com with ESMTP id d74sm2307442wra.2005.09.07.14.34.29;
        Wed, 07 Sep 2005 14:34:29 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bog6082.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8181>

Actually, I'm cherry-picking the easier ones in an effort to reduce my 
stress about my impending move to the LA area.

Hopefully you did git-diff-script, git-format-patch-script, and 
git-rev-parse which don't look easy to document.

Junio C Hamano wrote:
> You read my mind.  I just finished documenting some other
> commands and was about to push things out.
