From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Google Code supports Git
Date: Sat, 16 Jul 2011 17:18:16 -0400
Message-ID: <4E220018.3080005@gmail.com>
References: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com> <CAGdFq_h4E75LDWkQjkp_DvOAWUC_H+2KEvWMeGviPuFSJWGu+w@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 23:18:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiCFz-0005Et-8e
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 23:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab1GPVSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 17:18:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48072 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1GPVSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 17:18:23 -0400
Received: by iwn6 with SMTP id 6so2078678iwn.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=qqrZnSG7NZifw4vo7A6WSgX83fbyXnCtQk1AhgTF5Jo=;
        b=TrKdH19MN5KVBrr1K8/CNTVrPbOWGn5o8wAlAMkT0WUAPv+5qTAndkWxB0QQvnidbF
         Me2KditmmfbN2+nhM9djPMrlHauT5t2UryhB3Z80rvDX3DcwTplSAQwjLr4YCzy/pFxB
         KRW3OvJV9U6OM0ND3CrVQY+OPKdtzaSEPbNzY=
Received: by 10.43.46.198 with SMTP id up6mr4407317icb.149.1310851102192;
        Sat, 16 Jul 2011 14:18:22 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-162-240.nycap.res.rr.com [67.248.162.240])
        by mx.google.com with ESMTPS id ft12sm1798301ibb.2.2011.07.16.14.18.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 14:18:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110702 Icedove/3.0.11
In-Reply-To: <CAGdFq_h4E75LDWkQjkp_DvOAWUC_H+2KEvWMeGviPuFSJWGu+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177286>

On 07/16/2011 04:44 PM, Sverre Rabbelier wrote:
> Heya,
>
> On Sat, Jul 16, 2011 at 12:24, Nguyen Thai Ngoc Duy<pclouds@gmail.com>  wrote:
>> Just out of curiousity and because I happen to know we have Googlers
>> here. If it's not confidential, are there any changes in git to make
>> it work with Google Code? I am particularly interested in whether
>> Google modifies git to use bigtable (or cassandra, I remember Shawn
>> had a prototype).
>
> If nothing else, the "hg on bigtable" talk from I/O 2008 is probably relevant.
>
> http://www.youtube.com/watch?v=ri796Hx8las
>

I know I would would appreciate it and I believe many on this list would 
also appreciate understanding how git hosting in Google code was 
implemented.
