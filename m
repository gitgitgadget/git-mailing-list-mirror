From: Jiang Xin <worldhello.net@gmail.com>
Subject: L10n for Git in Chinese begins
Date: Mon, 30 Jan 2012 16:55:11 +0800
Message-ID: <4F265AEF.5020409@gmail.com>
Reply-To: worldhello.net@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 09:55:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrn1F-00074k-29
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 09:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab2A3IzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 03:55:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40315 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab2A3IzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 03:55:13 -0500
Received: by iacb35 with SMTP id b35so4897617iac.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 00:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ENvoumdOv+6s8C1CEl+x/HqOP8wJKf9A8l7rv4vXR04=;
        b=p4DS3gSSj9xJNpF8wNiBWjfYrmZY9Y+YjPxw+xtTJrSwC9f6ovFRnvQFG3SCiwtJPr
         RQF3Kc4JpC3/TnJbxI3ZQ5w+lPQ6bWYgSIjQV97cjvBiTBs5BkakfBZ7zaT5EibDb3PW
         UK85fu51H5dSVGm/tZMI1MB6Au9htNd4mAYDM=
Received: by 10.42.189.5 with SMTP id dc5mr13166063icb.51.1327913712779;
        Mon, 30 Jan 2012 00:55:12 -0800 (PST)
Received: from [192.168.0.100] ([123.116.229.89])
        by mx.google.com with ESMTPS id v10sm2027916igv.7.2012.01.30.00.55.10
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 00:55:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189332>

With the release of v1.7.9 or some earlier , Git is multilingual.
I select some typical git commands and translated into Chinese,
works nice.

- git status (in c)
- git stash (in bash)

Now I create a repo in Github hosting the po file (zh_cn.po) for git.

- repo: https://github.com/gotgit/git-l10n-zh-cn/
- file: https://github.com/gotgit/git-l10n-zh-cn/blob/master/zh_cn.po

Any help is appreciated, and will contribute here after 100% completed.


-- 
Jiang Xin
