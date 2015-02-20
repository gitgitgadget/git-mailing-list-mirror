From: sojourner <sojournerh@gmail.com>
Subject: Re: git mac 10.7.x
Date: Fri, 20 Feb 2015 15:06:20 -0500
Message-ID: <DC25FF7E-8A11-4755-B3CA-3DA87F2B3950@gmail.com>
References: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com> <CAH6Pt5rm2jrGst3Lm3a5xdum_1sxh3G+xLD0TVhCSLi4jh5fvw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthew Brett <matthew.brett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOtqG-000178-3S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 21:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbBTUGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 15:06:23 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:35316 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbBTUGX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 15:06:23 -0500
Received: by mail-qa0-f47.google.com with SMTP id v10so14053362qac.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2x++1iij3Id/J8oN4nnZDfbLXQI3nWPd9gsuz7G1slI=;
        b=ho+Sse16MOjTyMEceb3srvdmM2BRT6npJe84h4A3JYBmfFDsog9XRL1f/Vw9WkMSrF
         1N0MYx4vV1Yba4+8GogEFGj3dQBSEjhY9QGUYordoZQQBXqpuky0mDRFbJA9tfuWT/CQ
         K4aXVya6UtzEoqt6qCmx5CEucYa6j4P7u8NiLvb0BftU1cE6+JeTJXkNzGraIZrOGJAS
         YHm00XJ98hDRq/6jhWSqHml9h7R8I31lZIpdZTLc6EtBNVETxEZTfP8d5IZ0HyzLKUGT
         QorvaFBOQBysRG6buBdvHqaQ4n56+kHiqWxQfvrTaDDAYdqs3XHnm8AkKUiEH/cu5iak
         XDAg==
X-Received: by 10.140.107.227 with SMTP id h90mr26713573qgf.71.1424462782436;
        Fri, 20 Feb 2015 12:06:22 -0800 (PST)
Received: from [172.31.98.217] (rrcs-208-105-47-124.nyc.biz.rr.com. [208.105.47.124])
        by mx.google.com with ESMTPSA id l78sm10152306qhl.34.2015.02.20.12.06.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Feb 2015 12:06:20 -0800 (PST)
In-Reply-To: <CAH6Pt5rm2jrGst3Lm3a5xdum_1sxh3G+xLD0TVhCSLi4jh5fvw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264183>

Yeah, the neuroimaging site's info was unhelpful. 

Does anybody have anything that's actually worked? 


On 20 Feb 2015, at 11:35, Matthew Brett wrote:

> Hi,
> 
> On Fri, Feb 20, 2015 at 2:38 AM, sojourner <sojournerh@gmail.com> wrote:
>> Installed Git via installer. Updated path in .bash_profile. Get error Illegal instruction: 4 when trying to run Git.
> 
> I've seen the installer problem - suggestions here:
> http://practical-neuroimaging.github.io/installation.html#if-you-are-on-osx-10-8-mountain-lion-or-below
> 
>> Built Git from source. Searches for the compiled source unsuccessful. Which is nice: there's nothing to uninstall.
> 
> I'm not sure what happened there :)
> 
> Best,
> 
> Matthew
