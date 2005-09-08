From: Tim Ottinger <tottinge@progeny.com>
Subject: Re: Merges without bases
Date: Thu, 08 Sep 2005 13:01:54 -0500
Message-ID: <43207C92.4040103@progeny.com>
References: <1125004228.4110.20.camel@localhost.localdomain>	 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net> <1125010764.4110.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 20:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDQjq-00067N-Nt
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVIHSDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVIHSDD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:03:03 -0400
Received: from zealot.progeny.com ([216.37.46.162]:54941 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S964914AbVIHSDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 14:03:03 -0400
Received: from [192.168.0.65] (pcp961871pcs.brnsbg01.in.comcast.net [68.58.143.126])
	by morimoto.progeny.com (Postfix) with ESMTP
	id B73BD636A4; Thu,  8 Sep 2005 13:03:01 -0500 (EST)
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1125010764.4110.35.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8207>

Darrin Thompson wrote:

>What I'm going to do is actually an inversion of that. Publishing a
>repository with the _intent_ of being merged into existing history, and
>observing obvious naming conventions as the "prior arrangement".
>
>I thought once I got the initial baseless merges done and committed that
>I do fetch-octopus from that point on. But octopus was still complaining
>about not finding a merge base. I'm going to verify that I didn't just
>mess something up in the process.
>
>If I can get octopus working as the tool for doing merges _after_ the
>baseless merges then I can live with the current situation. 
>  
>

Heh.  Git repositories as components.

-- 
                             ><>
... either 'way ahead of the game, or 'way out in left field.
