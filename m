From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects.
Date: Mon, 29 Aug 2005 14:57:46 -0400
Message-ID: <43135AAA.4070406@gmail.com>
References: <43102727.2050206@tuxrocks.com>	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>	<4312BC27.9010604@tuxrocks.com>	<7vvf1obsfc.fsf@assigned-by-dhcp.cox.net>	<7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>	<43135414.6080400@gmail.com> <7v3bosbn1o.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 21:00:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9opN-00069Y-F2
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVH2S5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVH2S5u
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:57:50 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:9782 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751300AbVH2S5u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:57:50 -0400
Received: by wproxy.gmail.com with SMTP id 58so513798wri
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 11:57:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Fj1ipCNeW40JeVmYQPofx+BVEhVUb5Iy+/1HxcKgEA9WW0TSA41sdam/T51eX8ekcrzZGl3v1i++ULog0sBo4mCVr7fbCqFPC+MrkzEtUf3VAL06onKZRWrC/ne6mvbkbMp3vueb8s3SRc9VblDFhBORPD6Vb38naagkij3wKgE=
Received: by 10.54.49.34 with SMTP id w34mr6773021wrw;
        Mon, 29 Aug 2005 11:57:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 14sm48337wrl.2005.08.29.11.57.48;
        Mon, 29 Aug 2005 11:57:49 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bosbn1o.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7919>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>Frank,
>>
>>Can you produce a patch to update the git-repack-script documentation to 
>>reflect the new functionality?
> 
> Not including the doc changes in the patch was my fault, but the
> message was meant primarily as an explanation of what I meant,
> not for immediate inclusion in the master branch.
> 
> I have some other documentation updates sitting in the proposed
> updates, so I'd do it myself along with other manual pages if
> you and Frank do not mind.
> 
> In any case, I first would like to make sure that the proposed
> patch you are replying to is something Frank agrees to.
> 

I sent my request to Frank because he was/is the sponsor of the change 
but anyone can provide the documentation. :-)

I think it'd be a good idea for documentation updates to accompany all 
patches (and for the maintainer to not be shy about asking for them).

Just my $0.02 as I look at which commands have no documentation.
