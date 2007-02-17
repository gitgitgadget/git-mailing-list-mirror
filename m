From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/3] Wrap the log text in some nice HTML to highlight the commit message
Date: Sat, 17 Feb 2007 22:02:24 +0000
Message-ID: <200702172202.25730.andyparkins@gmail.com>
References: <200702172200.13461.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 23:05:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIXgK-0005RD-0D
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 23:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbXBQWFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXBQWFU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 17:05:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:8301 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030259AbXBQWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 17:05:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so404126uga
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 14:05:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ThKAEHPNPx3DaPpY42mg14qaLlgcmZR/Zi0xOq0fJP29ef7N1YVmg+npp7QMq3+UIO7RjZ22ji2w5caMTfC3jD2KPGKmEsvY9LztKm7y5z/KuX4G6vf4DN19sUYJAx0jZ9stw/8IReNBjFj69HB20cbXohcQl7Ihg6+11HmQu6M=
Received: by 10.67.96.14 with SMTP id y14mr4766122ugl.1171749918566;
        Sat, 17 Feb 2007 14:05:18 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j34sm5413552ugc.2007.02.17.14.05.16;
        Sat, 17 Feb 2007 14:05:16 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <200702172200.13461.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40017>

On Saturday 2007, February 17, Andy Parkins wrote:
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> Hey Marco; I've finally got around to rebasing.  The problem I had
> was an error in my .git/config was making git-fetch just return
> without fetching so I wasn't getting your new master head.

Apologies all: this and following patches should have been marked qgit4; 
not mainline git.

Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
