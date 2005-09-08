From: A Large Angry SCM <gitzilla@gmail.com>
Subject: git-stripspace unfairly accused of being undocumented.
Date: Wed, 07 Sep 2005 22:02:39 -0400
Message-ID: <431F9BBF.6@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 08 04:04:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBkY-0005nH-6a
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVIHCCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVIHCCr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:02:47 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:3154 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932558AbVIHCCq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 22:02:46 -0400
Received: by wproxy.gmail.com with SMTP id i2so1085950wra
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 19:02:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=VoAd9EYjLeR48XGFn7ugmda7o2IMHvr3C7X2Eu3rN8G4dc0m1ewV29OFC0GmZXbL7gS36xHZuu/crouZeQys//AhwqWCw7bkzIVowY/UhzZuzFczjsmf5GjIOW+w0qTgqVFrkNu/3v5Z8JgV9z/5Iu17f6N3x+cWRresQCG0O/4=
Received: by 10.54.63.16 with SMTP id l16mr4321778wra;
        Wed, 07 Sep 2005 19:02:45 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 12sm9809970wrl.2005.09.07.19.02.45;
        Wed, 07 Sep 2005 19:02:45 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8188>

Junio,

Looking over the latest commits I just noticed the "no documentation" 
section in git.txt lists git-stripspace in error.
