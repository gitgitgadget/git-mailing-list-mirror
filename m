From: Francis Moreau <francis.moro@gmail.com>
Subject: git-remote add: --no-tags/--tags which one is the default option
Date: Mon, 02 Mar 2015 10:48:24 +0100
Message-ID: <54F431E8.3050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMxj-0005SR-EW
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbbCBJs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:48:27 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33356 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbCBJs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 04:48:27 -0500
Received: by wghb13 with SMTP id b13so32230589wgh.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=cQPqw/8v/l6CcL44o36NuTfIBP4W5vk0+FjmT7wumFo=;
        b=gddFLXL6gcJrghPmJoqGxcLj0u5Vn/+ILBpVkMoBuuTY/NPQGnzdKFDtcvWYvduLAp
         F3iQgWVuu1AMNcdkP04xgc0XQqxMlVf4ZhSf7O1w+NIKdVwrBwqxzkmvrPX2UAeHEAdn
         jKzVLbf+5dtzvNcxc8r39hXIpVGXx2qhoOhbhsNMOU+OWGVPi21uHalAZE9FXzwcK9QU
         aXARvc7WPpvU0s/YNmwkXhvDHjzNqx1cA7MO2yYE0Qd8PRKS4kfBOtzp1lRusfx79HFP
         mMkj17XlIOZ1Yyx36qPNDlc1W5LjJpN6F/4CF4zgQTFUg0Uxmz96Wgt9iS45m98mYI0E
         azLA==
X-Received: by 10.180.207.237 with SMTP id lz13mr34081978wic.15.1425289705692;
        Mon, 02 Mar 2015 01:48:25 -0800 (PST)
Received: from [192.168.0.17] (gem13-1-78-228-1-221.fbx.proxad.net. [78.228.1.221])
        by mx.google.com with ESMTPSA id hm6sm18449177wjb.32.2015.03.02.01.48.24
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 01:48:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264589>

Hi,

git remote add has --no-tags/--tags option, but I can't find in the man
page which one is the default.

Could anybody tell me the default option ?

Thanks.
