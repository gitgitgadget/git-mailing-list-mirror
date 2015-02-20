From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git mac 10.7.x
Date: Fri, 20 Feb 2015 10:32:24 -0800
Message-ID: <1768B135-0FC3-49FE-AD9A-D33E39F822B6@gmail.com>
References: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sojourner <sojournerh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 19:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOsNM-0005fP-7T
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 19:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbbBTSc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 13:32:28 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43159 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBTSc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 13:32:27 -0500
Received: by pdev10 with SMTP id v10so9307646pde.10
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=0o1MjQFSYLmx93RR8oTGmQwGMI0stItZ5qGA0sQ27bc=;
        b=jg/JRvRkMe2XjdGoeubF4G0fxRvROogTxNfzX05Rilcls8TAjWwLQhoPlgcvvWLQn4
         iDOXYUA/UJjmhfVg7RTsIKigbT71desgSbIDSKmTKCOB2ejq9R9jRTArp3xAoljk5AlO
         P8whnrBUd+wI9dz6cNecspL3GFa7uo3m/dspLxAS0iC+9zw1zkMe6wqCYAqj5fm3Ub5w
         Q7uX71UeLtyumWKMwkN9heeohX4naCdFJ0j2vAKVnDLxXC6Ngiqt8WyoxR8Xd2eAuqJd
         sVBVpJsl5H95Kt7fn2hvJ255XQtSfOT7XjSfHR4/YHPqJ0P5ulG30oXx0TGmXAgfMHI0
         8IPA==
X-Received: by 10.70.91.8 with SMTP id ca8mr9162407pdb.156.1424457147316;
        Fri, 20 Feb 2015 10:32:27 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qz3sm27889642pab.13.2015.02.20.10.32.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Feb 2015 10:32:26 -0800 (PST)
In-Reply-To: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264176>

On Feb 20, 2015, at 02:38, sojourner wrote:
> Installed Git via installer. Updated path in .bash_profile. Get  
> error Illegal instruction: 4 when trying to run Git.
>
> Built Git from source. Searches for the compiled source  
> unsuccessful. Which is nice: there's nothing to uninstall.
>
> Searching online has a lot of suggestions and ideas. Anybody have  
> anything that actually works?--

You can get a working installer from <http://mackyle.github.io/git-osx-installer/ 
 > that should work for you on 10.7.x just fine.

-Kyle
