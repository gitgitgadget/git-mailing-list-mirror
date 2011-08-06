From: jelly <sinojelly@163.com>
Subject: Re:Re: I suggest that git commit support -A option, just like hg
 does.thanks.
Date: Sun, 7 Aug 2011 00:17:34 +0800 (CST)
Message-ID: <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com>
References: <20110806150246.GA20650@jpl.local>
 <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Magnus_B=C3=A4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 18:17:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpjZM-000457-Uq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 18:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab1HFQRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 12:17:43 -0400
Received: from m13-7.163.com ([220.181.13.7]:59036 "EHLO m13-7.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754408Ab1HFQRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 12:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Cc:Message-ID:In-Reply-To:
	References:Subject:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=z5D7he6g7fyi23kx+9mvC959YwNmJQvtY8
	n6UWoyLk0=; b=aQPQ69/kP7G+ZY1gFLjfld2QiKm31C2ieCDJkWXWrCFDZQMBuI
	vBgCDB8529mEPNaN15x+pCyehJElFOSZ/4C4II3s5aeyt7afnTluVt0nwAZvtm+y
	01xKJQrsb9vOOogpWqrObQTW3o+DMIfTXTMQ9PcASdNX5ozmCoPEHDUxQ=
Received: from sinojelly ( [112.64.214.244] ) by ajax-webmail-wmsvr7
 (Coremail) ; Sun, 7 Aug 2011 00:17:34 +0800 (CST)
In-Reply-To: <20110806150246.GA20650@jpl.local>
X-Originating-IP: [112.64.214.244]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 110713(13936.3901.3890) Copyright (c) 2002-2011 www.mailtech.cn 163com
X-CM-TRANSID: B8GowKB7K0seaT1OumAjAA--.58646W
X-CM-SenderInfo: pvlq0yphoo5qqrwthudrp/1tbiER6TyUi7aDS7hQABsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178884>

>It=C2=A0seems=C2=A0like=C2=A0you're=C2=A0looking=C2=A0for=C2=A0the=C2=A0=
-A=C2=A0option=C2=A0to=C2=A0"git=C2=A0add".

I don't want to run "git add -A" before commit,=C2=A0
I want to use "git commit -A -m 'msg' " instead.
