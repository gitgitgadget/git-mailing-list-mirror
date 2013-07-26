From: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
Subject: Git on intranet
Date: Fri, 26 Jul 2013 15:36:25 +0200
Message-ID: <51F27B59.8020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 15:36:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2iCE-0003dV-3A
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 15:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656Ab3GZNgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 09:36:33 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:54983 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3GZNgd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 09:36:33 -0400
Received: by mail-lb0-f181.google.com with SMTP id o10so1321305lbi.40
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-tagtoolbar-keys:content-type:content-transfer-encoding;
        bh=QHYIz6udQRMqYGwAtVezKS+QtCGVj7e5huxlDf7gz1Y=;
        b=GdaQxl+t7bjIsVeDUwXpcRbxGDlQibZh3k4jAqYUCV4HAiJEcc87dCcJvlo4qVOXJW
         7W/jPaja2kBKMVGa8in+4BOTHx0nAgS7Bsq8hdSsV4VhtOU437kplXFD+mqgu51hgx50
         QHelER7JC37xCh5v6m5DgxuWkYr5F0VGmRPRJmS/73isPfw6utaXUST75LuMoei/qQbl
         T9w3lCOkcmaINIRwBHA/kvJ6HpJ2WB7zhyfhigTMr3HLZPtRL4f7nZMk8Is2fqZG9+j0
         RybuYg8xmirQ3S+VbE5epFvFk1lo3Zeg7Y+qeVcRtwzvAOv4QfsiHx5ttN8OIKFuTVkp
         ugIw==
X-Received: by 10.152.44.133 with SMTP id e5mr21854547lam.15.1374845791259;
        Fri, 26 Jul 2013 06:36:31 -0700 (PDT)
Received: from [0.0.0.0] (tor01.spacedump.net. [212.63.218.1])
        by mx.google.com with ESMTPSA id w17sm1002044lbg.12.2013.07.26.06.36.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 06:36:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-TagToolbar-Keys: D20130726153625007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231184>

Howdy,

I want to use Git over the local network in our company because the 
internet connection isn't stable so I wonder how can I use git with pull 
request (similar to Github)?

As I read about Gitorious.org I found it most candidate but I'm not sure 
is it supports this feature or maybe there is better open source solutions!

-- 
Best Regards,
Muhammad Bashir Al-Noimi
