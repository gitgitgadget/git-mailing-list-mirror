From: Paa Kojo Konduah Amos <pkkamos@gmail.com>
Subject: git clone command
Date: Wed, 13 Jun 2012 05:09:36 +0000
Message-ID: <4FD82090.8010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 07:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sefq6-0001Sd-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 07:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2FMFJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 01:09:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38283 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2FMFJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 01:09:42 -0400
Received: by eaak11 with SMTP id k11so35530eaa.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=X/xk7k7SZ0gD0EGzQ0MxVXy8noSEWxKDaHke0sgzuJY=;
        b=wZDHEWB6GNBDDWZY1mKDo0KyE58/1UqqUvOLF6KobtfBSuC6UHnPXsC+AM8gRpjy2k
         sKes+VNBaZPzauDhEhERT07kXb7TsiT8gv8gtHpWMM+5sJliHu7Z4lYYr0fkJwnC0rjb
         O9T/Vc4otnc9QRZscYJKNRI+aqS7G05TcuI49UeVRqTLV076c0tO37zRHz7mOSX2vmEU
         NVfb8+65j7WYO38WpzH8Ep8EuRRyuPpWIQMIu/qEm0xwHp87mPUFgoyZJo/2fxEdwGKs
         nS1N0pbIMRiO2SV6XP5iDuROgE4SfJvnh3SzUiO4m4wpTVQnyx3YahatxxvqQXSDAAI9
         j6PA==
Received: by 10.14.127.136 with SMTP id d8mr7404323eei.159.1339564181806;
        Tue, 12 Jun 2012 22:09:41 -0700 (PDT)
Received: from [41.93.134.100] ([41.93.134.100])
        by mx.google.com with ESMTPS id q53sm3100361eef.8.2012.06.12.22.09.38
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 22:09:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199873>

hello, i have been working with git for some time now... and i have just 
been hit with a serious problem in the middle of a major deployment of 
our project.

Problem: when i do a "git clone" on the server url without specifying 
the actual git repository..the command still pulls files of a previous 
clone rather than warning me the repository does not exist.

PLEASE what might be wrong...is there something like clean some 
cache.... i am really hot now!!!

Thanks.
