From: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
Subject: Re: Git on intranet
Date: Fri, 26 Jul 2013 16:21:28 +0200
Message-ID: <51F285E8.5040802@gmail.com>
References: <51F27B59.8020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jul 26 16:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2itv-0005O9-EY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 16:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758971Ab3GZOVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 10:21:43 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53363 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134Ab3GZOVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 10:21:36 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so3285408pab.40
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:x-tagtoolbar-keys:content-type
         :content-transfer-encoding;
        bh=P2FujBvgY+QihdNeWIZLBsgDPZbdCsMEJmuPMcJ2usE=;
        b=X9MJk+whJyEHu3WuLVYG6a1+jWRfQaj73RQmOtbxCKtRydllVZU2ZT893GOizaCgH+
         jGIRtSExJmKWQI6FZVo8IS4JMX6tnYLdPgNfPBRdWEpmK9KX/q7HhtD8FuUonguQbIug
         7PptLM3PNBGWm/iReEa49qtiY+wgSZE4LpWKzdSzZZQbDayhV90ykk/bPQEyCHvggJoI
         G4orjiPJiEnNqcIpNyoT2Mjag5G4ZPsK4NRo85Pj3sbUfVwP7CKVfKHFkl+gvYc2poTM
         ysod/9VkwSBQRcoaB+KQcD9wcyLtBaxw12fUyVfGIdsvEspyqSU9ZtyG72TdGIMz4CHB
         XTmA==
X-Received: by 10.68.211.138 with SMTP id nc10mr54142448pbc.162.1374848496004;
        Fri, 26 Jul 2013 07:21:36 -0700 (PDT)
Received: from [0.0.0.0] (exit-01d.noisetor.net. [173.254.216.69])
        by mx.google.com with ESMTPSA id br1sm60467133pbb.4.2013.07.26.07.21.32
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 07:21:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51F27B59.8020608@gmail.com>
X-TagToolbar-Keys: D20130726162128459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231185>

On 07/26/2013 03:36 PM, Muhammad Bashir Al-Noimi wrote:
> Howdy,
>
> I want to use Git over the local network in our company because the 
> internet connection isn't stable so I wonder how can I use git with 
> pull request (similar to Github)?
>
> As I read about Gitorious.org I found it most candidate but I'm not 
> sure is it supports this feature or maybe there is better open source 
> solutions!
>
Best search result I got is: http://stackoverflow.com/a/2593330 the user 
says that both *Gitolite* <http://sitaramc.github.com/gitolite/> and 
*Gitorious* <http://gitorious.com/local_install/> are very hard to 
configure!!! What do you suggest?

-- 
Best Regards,
Muhammad Bashir Al-Noimi
