From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Git difftool / mergetool on directory tree
Date: Wed, 14 Dec 2011 09:42:54 +0100
Message-ID: <4EE8618E.7020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RakO9-0001nF-ML
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 09:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab1LNIk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 03:40:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57888 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1LNIk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 03:40:28 -0500
Received: by eaaj10 with SMTP id j10so476714eaa.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 00:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=SAf6WmNT5o8UxD1i+uYo0yrDWjlM3F17h6+9F4T6ewk=;
        b=WAje9TlP+mQA8p+0/KCTt08KFRtANyWyGDDxcw1y8RQvrwphIJRLd3gfz337OYBnR3
         Ht6jzUle3+POdoBxb9a/AFy0aowwofUzY8xbqcRrqpP0OsMMEJ5Q3JGkF9x+zlfXDlMP
         o+y6ULqMaufZK+rjYiAugyWE3q74wMg7vWtbU=
Received: by 10.205.128.132 with SMTP id he4mr323460bkc.123.1323852027563;
        Wed, 14 Dec 2011 00:40:27 -0800 (PST)
Received: from [192.168.1.64] (host42-66-dynamic.20-79-r.retail.telecomitalia.it. [79.20.66.42])
        by mx.google.com with ESMTPS id z7sm4078551bka.1.2011.12.14.00.40.23
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 00:40:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187101>

Hi,

many diff / merge tool around have the ability to compare a directory 
tree (meld is one, but there are many).

Is there a way to start a difftool or a mergetool on a folder instead of 
the single file?

It would be an handsome feature to git.

I googled a little before popping out this question and I only found 
suggestion on how to open "many" file at once instead of opening them 
serially but that's not the same thing not as powerful as directory 
comparison.

Thanks,
Daniele
