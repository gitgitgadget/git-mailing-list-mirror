From: =?ISO-8859-2?Q?Martin_P=F8ececht=ECl?= <precechtel@gmail.com>
Subject: Git repository clonning
Date: Fri, 17 Feb 2012 12:21:46 +0100
Message-ID: <4F3E384A.3040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 12:22:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyLt2-0001ht-CH
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 12:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab2BQLVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 06:21:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32777 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab2BQLVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 06:21:50 -0500
Received: by bkcjm19 with SMTP id jm19so2936327bkc.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=VXpOsiKvs+LQB3fRcNYRGqO9vnLpB17w/cpy4vMlEhg=;
        b=G0XYYEsa/IPbB1K98nqPzk3kar0OUyuml9SEbTCyXBDTn9MYV9z+v8FjWM2i6g0RSN
         xqdyysX/EveP1W0UqHhjrHaZzcjXI0FUkvcnUugXAqUaHKr+wqSb6hKg5TYjlHIrd/5g
         h2Ky4YIaNdzE3dBvhv+GBEfdfSe19hZsqHTTw=
Received: by 10.204.151.196 with SMTP id d4mr4063333bkw.29.1329477709295;
        Fri, 17 Feb 2012 03:21:49 -0800 (PST)
Received: from [192.168.2.53] (server-plzen.juhacr.net. [89.235.39.234])
        by mx.google.com with ESMTPS id x22sm22215216bkw.11.2012.02.17.03.21.47
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 03:21:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Iceowl/1.0b2 Icedove/3.1.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190948>

To Whom It May Concern,
I have a problem and I would like to ask you for help. I need to somehow 
access the git repositry over network and read files from it. In the 
concrete, only thing I need is to read some files from repository, where 
I have files needed for installation of computers. So on  computer where 
installation takes place, I need to read from this repository some files 
needed for installation process. I tried command git clone 
<my_repository> but this command download the whole repository which 
size is now almost 8GB files + 4GB .git folder. This process is very 
slow. So I want to ask you if there is a way how to access my repository 
(read some files from it) but to significantly improve speed. Is there 
for example something what will somehow map the repository to folder and 
then dowload only thouse files which are accessed?

I would appreciate any help.

Thank you for your time,
Yours faithfully,
Martin Precechtel
