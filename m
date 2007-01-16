From: Andy Parkins <andyparkins@gmail.com>
Subject: git-show ignores --pretty
Date: Tue, 16 Jan 2007 10:58:11 +0000
Message-ID: <200701161058.15725.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 11:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6m1O-0001H6-Ai
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 11:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXAPK6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 05:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbXAPK6V
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 05:58:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXAPK6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 05:58:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1635446uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 02:58:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BKA1ayA5P4Alo+O0gWx8m0YqaivkrzzpTUKSCyYpfyj1z/6MqLc5Ozli1qHdtj9muiLQSETRM1IpUaMXqXGYSUOtvD34C+ubL/P0l8BjOpVWgzMdGiYTVswlPXFMl2Sgfz8neYSMZLqtVsJdeA1KCx34a3OiUyHUUwTf6ygFBdM=
Received: by 10.66.219.11 with SMTP id r11mr7164066ugg.1168945098848;
        Tue, 16 Jan 2007 02:58:18 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id l33sm6801521ugc.2007.01.16.02.58.18;
        Tue, 16 Jan 2007 02:58:18 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36926>

Hello,

$ git --version
git version 1.5.0.rc1.gf4b6c

Running git-show with a --pretty format is no different from without 
a --pretty.

Doesn't seem to matter what format you pick, you always get medium/full.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
