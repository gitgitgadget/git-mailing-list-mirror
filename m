From: Jiang Xin <gotgit@163.com>
Subject: L10n for Git in Chinese begins
Date: Mon, 30 Jan 2012 16:21:59 +0800
Message-ID: <4F265327.50805@163.com>
Reply-To: worldhello.net@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 09:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrmV3-0000tm-S5
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 09:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab2A3IWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 03:22:00 -0500
Received: from m50-134.163.com ([123.125.50.134]:60487 "EHLO m50-134.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2A3IV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 03:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Message-ID:Date:From:Reply-To:User-Agent:
	MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
	bh=0TFQIz1n+5VkGm520Sgs5e2gvWFYb+3w3y8o+gboxfs=; b=eZ/FJlLp0l6hb
	fOqtUxiE+ZoPYm2MsXiZPmAeXUcQT4PKiVw/XP6iV4mm/Ws6KOOlvqTefjZuRkPT
	RlSSR9/dekEbmDpnQy8OaFvgjLG++al2is8TVEdqFJssboEZNtROMe50Didz/ll8
	L/WrMJTi88K0IcTTxZ+bG1Q8HM0zw0=
Received: from [192.168.0.100] (unknown [123.116.229.89])
	by smtp4 (Coremail) with SMTP id DtGowEBJ5GUjUyZPCjsgCA--.336S3;
	Mon, 30 Jan 2012 16:21:55 +0800 (CST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-CM-TRANSID: DtGowEBJ5GUjUyZPCjsgCA--.336S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTLZ2DUUUU
X-CM-SenderInfo: 5jrwwxrw6rljoofrz/1tbiqwFFUkgY0lO0QwAAsb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189328>

With the release of v1.7.9 or some earlier , Git is multilingual.
I select some typical git commands and translated into Chinese,
both works.

- git status (in c)
- git stash (in bash)

Now I create a repo in Github hosting the po file (zh_cn.po) for git.

- repo: https://github.com/gotgit/git-l10n-zh-cn/
- file: https://github.com/gotgit/git-l10n-zh-cn/blob/master/zh_cn.po

Any help is appreciated, and will contribute here after 100% completed.


-- 
Jiang Xin
