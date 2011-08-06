From: jelly <sinojelly@163.com>
Subject: I suggest that git commit support -A option, just like hg
 does.thanks.
Date: Sat, 6 Aug 2011 22:32:53 +0800 (CST)
Message-ID: <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 16:48:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpiBO-0001r2-Ah
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 16:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab1HFOsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 10:48:52 -0400
Received: from m13-7.163.com ([220.181.13.7]:34569 "EHLO m13-7.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab1HFOsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Message-ID:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding; bh=E4lDT89T
	nzXJriLlGxi1MotM5X+UvkQAGb9CH2HT+aA=; b=UIEEiVn7nAw75dTDXnSoYLCz
	BUvTmjmpeSQ9EC9x2V6vhGJsYYo6zHQ2fkYzAQUPTfnaqNPbcpcUeh7/iZa6f/IE
	ht0PthH0z9SiAuVlYpXi8hSUCzQR1vQSlsQJMrkCdxxyD7coN/jSHfZ12nPiP53L
	mt+OiNOWV2CNtx900Vc=
Received: from sinojelly ( [112.64.214.244] ) by ajax-webmail-wmsvr7
 (Coremail) ; Sat, 6 Aug 2011 22:32:53 +0800 (CST)
X-Originating-IP: [112.64.214.244]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 110713(13936.3901.3890) Copyright (c) 2002-2011 www.mailtech.cn 163com
X-CM-TRANSID: B8GowKBb10qVUD1OLFcjAA--.15691W
X-CM-SenderInfo: pvlq0yphoo5qqrwthudrp/xtbBEQCTyUij8dx86QABsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178881>

$ hg help commit
hg commit [OPTION]... [FILE]...
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -A --addremove =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mark new/missing files as added/removed before=C2=A0=
committing
