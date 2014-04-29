From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 1/6] pull: rename pull.rename to pull.mode
Date: Tue, 29 Apr 2014 08:32:45 -0500
Message-ID: <535fa9fddcd12_6d5dff2f075@nysa.notmuch>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
 <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com>
 <1398774271999-7609129.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 15:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf8Jh-0008Mf-4P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 15:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbaD2NnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 09:43:21 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:51534 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbaD2NnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 09:43:20 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so195710yhn.35
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=patpWkelq6F7dfm5xzzszpJrNoXQmLPeDjwTjU+ta30=;
        b=YoJqVRsVbrUxX45VM0UPq85NBqNLvVBzTinDWl9tLAfv2DCRNQ300F87LbKOklBLse
         RoUI0hb9T4tgvCD/m3Gu+JepyCs3gcAEKhtrwgp40jVlzOMHdFlLJ4NTNN9U3SesO/O3
         Q9lHc81NaREhZHdnDyL0XBZpzErY7kWTdbpBCaCYeOuvSv1Ngb/JkRahpJ0gVWWzl62l
         m5Xu7XCqQba5+5KdnQyHHneHtFZ+y6F30KKkCjQrtj7rCDnxNHESAzUz3FPkbBPyrX/9
         z4xNQ23hoanMG/PC6u80rcOwMdJGB9npBsaN5K8m5gE+5AfFg33Kz0achco9krAWDn0B
         3xww==
X-Received: by 10.236.207.194 with SMTP id n42mr2525408yho.153.1398779000083;
        Tue, 29 Apr 2014 06:43:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e4sm10992935yhe.42.2014.04.29.06.43.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 06:43:19 -0700 (PDT)
In-Reply-To: <1398774271999-7609129.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247585>

Marat Radchenko wrote:
> Felipe Contreras wrote
> > [PATCH v5 1/6] pull: rename pull.rename to pull.mode
> 
> s/pull.rename/pull.rebase/

Right. Will fix.

-- 
Felipe Contreras
