From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Big Java repositories to play with?
Date: Wed, 07 May 2014 16:06:19 +0200
Message-ID: <536A3DDB.5020706@gmail.com>
References: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com> <536A374E.2050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 16:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi2UO-0008DE-69
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbaEGOGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:06:23 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:38189 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbaEGOGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:06:22 -0400
Received: by mail-ee0-f50.google.com with SMTP id e51so779287eek.37
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=OhUbAIYMNOzB67O2eb3ZMgu0TvOSO+sCdSocTPIDMTo=;
        b=ow5R6ybudWA5ROSZKbeaP6EhclrSff7+T/F2j+kZ0h8qrcT7VZZEfbmOlGm1QQ/qhp
         BXS8PM3qBthLwGjexjjkNWPfs+RyWAuw6Y9nam+xMIOpQgyZyDgApl+KcDEp7v0lP0eY
         C9zHUuI6anw+mJbx6Fr/XXFDph74yesHwXHsy+gVFFI4GI+EXgsYQvmAq8Q4rBJ7EdUQ
         VBT0I3P9OpRIQ9jAWi7nJgb/7wMsfAPZJJhhqjo8aYU8m2omj+vjlupdGqmsqro7XIUV
         fi5IKHVazoXyTTBqAcI7kFrI3RI9cBgmWGdQ9VH3Rx3Ga1aeyZFG4GWPmuCkSZvSRoyB
         1nUQ==
X-Received: by 10.15.101.9 with SMTP id bo9mr16700718eeb.75.1399471581247;
        Wed, 07 May 2014 07:06:21 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id p9sm35627792eeg.32.2014.05.07.07.06.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:06:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <536A374E.2050808@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248304>

On 07.05.2014 15:38, Stefan Beller wrote:
> On 07.05.2014 15:23, Duy Nguyen wrote:
>> I need some big Java repos (over 100k files) to test "git status".
>> Actually any repos with long path names and deep/wide directory
>> structure are fine, not only Java ones. Right now I'm aware of
>> gentoo-x86 and webkit. Let me know if you know some others. I'm afraid
>> my Google-foo is not strong enough to search these repos.
>>
> 
> I believe LibreOffice could do?
> (Just a guess, maybe I'm wrong)
> 
> https://www.libreoffice.org/about-us/source-code/
> git clone http://anongit.freedesktop.org/git/libreoffice/core.git
> 

Just tested, just 68k files, so it doesn't meet your requirement.
