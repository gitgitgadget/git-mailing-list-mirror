From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] show-branch: make --topo-order noop and default.
Date: Thu, 12 Jan 2006 18:24:41 -0800
Message-ID: <43C70F69.7010103@gmail.com>
References: <7v4q4ajonx.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 03:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExEcc-0000Yh-N1
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 03:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbWAMCYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 21:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWAMCYq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 21:24:46 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:43385 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932669AbWAMCYq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 21:24:46 -0500
Received: by zproxy.gmail.com with SMTP id l1so495490nzf
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 18:24:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pRoZUbSCcVfc2InOUhaCgsEO4ROnAOUTub/vywrI/vxgimYJkEfaXS0oDD1bTRT0D8Qy7fPM2Wn8ih/c9/Hv55TQFvo9F7z4drnLcEC7d0ihsLgNL4a7Q+l5h1bUIHOH1HkR2NDtyWWJ15UD/WzFg4RKldu3GctAZi4sGCv9bNU=
Received: by 10.65.218.4 with SMTP id v4mr1483491qbq;
        Thu, 12 Jan 2006 18:24:44 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id q18sm480784qbq.2006.01.12.18.24.43;
        Thu, 12 Jan 2006 18:24:43 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q4ajonx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14600>

Junio C Hamano wrote:
> It really does not make sense not doing --topo-order.
> 

I disagree. I do like to see the chronological commit history of some 
repositories.
