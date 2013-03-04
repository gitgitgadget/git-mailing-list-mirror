From: "J.V." <jvsrvcs@gmail.com>
Subject: git repo on Win 2008
Date: Mon, 04 Mar 2013 16:43:27 -0700
Message-ID: <5135319F.50404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 00:43:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCf2z-00046G-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 00:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab3CDXnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 18:43:32 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51759 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758586Ab3CDXnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 18:43:31 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so3552547pbc.40
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Nik0MSPeaHjC9KqL3jmTHzjmqiej+77KjOhFaPdWcBQ=;
        b=vPRXMmF54hxyfVvSWHQjSRTYjaEoZ5e7N/smdXx7gC0nHP8S7+irB2+rD004Uc3IVE
         /qM3Sj0oqiEAUvUOH3fhIK/A28SdjWGDOisOpjrgbJULehLVdjDHjR1LvSx4L1x2Ivyx
         9rnMc5iYRLLfTSjekyX17NgdKyTPtEUdN83LCCpFvdZZGkUtuysRn3VDtXrC7gnAQ/7f
         OUoZQveI93FF2t1tM/JWoXUnRBJe9pIJ9rVxmGfS39sHFOILBjcVhE6nXsen7Z7CV5i2
         QjypwbsXsFHpHn5PnZvyhV/cJ7wYEnGln0TSgsSdXKJaJ4XyV5RV74UMWyIJvvqcKoWG
         kbHA==
X-Received: by 10.68.251.167 with SMTP id zl7mr32085796pbc.116.1362440611002;
        Mon, 04 Mar 2013 15:43:31 -0800 (PST)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id i10sm24072400pbd.1.2013.03.04.15.43.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Mar 2013 15:43:30 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217420>

What is the best way to host a shared git repo on a Windows 2008 box?  I 
would like to create a repo on the 2008 box (that everyone will 
pull/push to), but add the initial code from my developer (Windows7 box).


J.V.
