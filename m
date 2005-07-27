From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 10:25:10 -0400
Message-ID: <42E79946.2020309@gmail.com>
References: <20050727083910.GG19290@mythryan2.michonline.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 16:26:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxmqd-00083x-3y
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 16:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVG0OZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 10:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVG0OZP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 10:25:15 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:12239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261290AbVG0OZM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 10:25:12 -0400
Received: by wproxy.gmail.com with SMTP id 57so187055wri
        for <git@vger.kernel.org>; Wed, 27 Jul 2005 07:25:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IgNXpVIHb/ztjB3y/DNEkvymsPHubUqdyJqGHweq3ffWkpNBdaXKzCk6d935tejqLJAfj+E2OVZqxLvIV7EpEdZ/Y7YqMh/d+z0X5j+GqvQMDTEZPu1t5fH5DGIpAQ0B+slvKwk1Hf3BVVzTypSJi3XJJksXG8PIUws9hFpaCKs=
Received: by 10.54.143.10 with SMTP id q10mr360382wrd;
        Wed, 27 Jul 2005 07:25:11 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g7sm639295wra.2005.07.27.07.25.11;
        Wed, 27 Jul 2005 07:25:11 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050727083910.GG19290@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson wrote:
> Convert build process from recurse Make to a single Make
> 

Please explain the rational for this.
