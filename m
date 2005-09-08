From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Add git-version-script.
Date: Wed, 07 Sep 2005 22:08:15 -0400
Message-ID: <431F9D0F.8070301@gmail.com>
References: <11259325781492-git-send-email-matlads@dsmagic.com> <7v1x402wiy.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 04:08:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBpt-0006bg-8w
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVIHCIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVIHCIS
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:08:18 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:54296 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932552AbVIHCIS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 22:08:18 -0400
Received: by wproxy.gmail.com with SMTP id i2so1086707wra
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 19:08:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FSg/8xQJkOtYhJXjO8E0CbhIDuN5r+4IINWoz/5s0pwe/C8VGg2iLyc3v+FclhVkQ44TRwKQT21sJy/bWFIS/u6XG2516aiDR0U/4ulf6FBSvqHcJC+n8HJWvL+Lac+Cu/R0f27yVOluGhl/YQOUt8HTuCvODKGu1P9GxZu1G3c=
Received: by 10.54.29.44 with SMTP id c44mr2639630wrc;
        Wed, 07 Sep 2005 19:08:17 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id d61sm4267074wra.2005.09.07.19.08.16;
        Wed, 07 Sep 2005 19:08:17 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x402wiy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8190>

Junio C Hamano wrote:
> Martin Atukunda <matlads@dsmagic.com> writes:
> 
>>This script simply reports the version of git you have installed.
> 
> I wanted to ahve some way of recording the git version, but I am
> wondering if 'git' without parameter telling the version number
> would be good enough without introducing yet another script.

git --version
