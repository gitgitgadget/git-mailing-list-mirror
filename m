From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Mon, 26 Mar 2012 09:41:51 -0500
Message-ID: <4F70802F.4020603@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net> <4F6BD1E2.2050607@gmail.com> <BLU0-SMTP315865C5026D08E76594E5DB1460@phx.gbl> <4F6C970B.2010803@gmail.com> <4F707CB4.3030308@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:42:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCB7Q-0003vz-5b
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 16:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2CZOlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 10:41:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48003 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2CZOly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 10:41:54 -0400
Received: by ghrr11 with SMTP id r11so3848855ghr.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YNNC9mwyN6D9XYD3XkMj2oucwvIXR7O9+ZkQJf9J8xU=;
        b=HVIM1WO1Yaw4oQTDUwMbwiIuvoAdeoFWAWfjKKhL1kqY8Z3ZAyFklLk4KM57NoTr+B
         9iCo6IjnhS2slwDfok6Z9+lZ/IYsJrxUndT3qefCJZ1z9RqRAPYbsSaLHvf5hpcLOFxz
         LXWCbvsfJMnfEKv/fYvyNzlPRTvxYDE34EALTtTu7xLjyrt9mSIEE+mPDswVicqrvifb
         TSMMv0qbWMWbPbS1IKqbw+JeZvQ6cN+gxX/y+//uFUI7oTAAK1urW5bUOMlq4smolN7P
         o2peHryVEb3++sDk3yc93pJvs4PojfFJjOmeqPL8PwmOod/GzaIOfVjKYRcYiSRXljTZ
         ICfQ==
Received: by 10.60.10.137 with SMTP id i9mr29245775oeb.23.1332772913828;
        Mon, 26 Mar 2012 07:41:53 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 8sm16530390obv.19.2012.03.26.07.41.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 07:41:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <4F707CB4.3030308@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193915>

On 3/26/2012 9:27 AM, Holger Hellmuth wrote:
> On 23.03.2012 16:30, Neal Kreitzinger wrote:
>
>> You would want to setup the gitignore before doing the init.
>
> Why that? "git init" doesn't add any files, the repo is still empty.
>
> I would even say "git init" helps because you get a comprehensive list 
> of non-ignored files with "git status" and can sift through that list 
> for files you want to be ignored
>
>
Thanks for correcting that.

v/r,
neal
