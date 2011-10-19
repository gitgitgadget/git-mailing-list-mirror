From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Compiling on Windows
Date: Wed, 19 Oct 2011 09:49:48 +0200
Message-ID: <4E9E811C.10205@lyx.org>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 09:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGQuY-0005Fr-5t
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 09:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab1JSHtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 03:49:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47875 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1JSHty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 03:49:54 -0400
Received: by eye27 with SMTP id 27so1341014eye.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 00:49:53 -0700 (PDT)
Received: by 10.213.101.4 with SMTP id a4mr729016ebo.32.1319010592552;
        Wed, 19 Oct 2011 00:49:52 -0700 (PDT)
Received: from [145.94.171.116] (wlan-145-94-171-116.wlan.tudelft.nl. [145.94.171.116])
        by mx.google.com with ESMTPS id w58sm13043664eeb.4.2011.10.19.00.49.50
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 00:49:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183926>

Op 18-10-2011 6:08, Andrew Ardill schreef:
> Hi list, I have been searching for details on what is required to
> compile on Windows, but haven't found anything conclusive. Perhaps
> there is something on the wiki, but unfortunately it is down at the
> moment.
>
> Can anyone point me in the right direction? I would like to be able to
> compile and test topic branches, and perhaps even do some dev work on
> my windows machine.

I once wrote a little step-by-step tutorial on how to compile the native 
Windows Git with MSVC (Express).

http://blog.vfrconsultancy.nl/#post0

Be aware that git runs without apparent problems, but that all 
functionality written in shell scripts can't be used.

HTH,

Vincent
