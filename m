From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] metagit 0.1.2
Date: Sat, 09 Oct 2010 01:48:39 -0700 (PDT)
Message-ID: <m362xbg3b3.fsf@localhost.localdomain>
References: <86k4lteow6.fsf@peer.zerties.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Dietrich <stettberger@dokucode.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 10:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4V6x-0004mQ-Kq
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab0JIIsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 04:48:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59596 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848Ab0JIIsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 04:48:41 -0400
Received: by fxm14 with SMTP id 14so896531fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=KBt0B2+lv1QUaQhrKpV7QQ1340LZDOlDH1ogd6eHwCg=;
        b=GXcF/XGXsAoHAOh1YNUvOrlm2uibF2NQ80ChN5TTVhu9iCG2cZVzR/hneI243yCRzf
         ZyiMn2rR+j88mdqgYyWjEiDq/x34fTqldGUkpnAWlni02ymScWR4F1HWkNHxg72+UFY0
         hoU5/ABcR+hdtVyK4dRyR0ScvS7WTrLSUP5Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mAP4MgvQhrTuSy0sea9gjAm5D/tkEheQkIbCbuc7bo5dsgkEfR+70VK5CNeqSM5ZHq
         URnaB6onODfnRYT3fIe5RMnoGaaCurLJUgdo5GqjphneJYptgwPPIxYaOYdovZAiQZNX
         Lt0sxhsANIQRveDpSmEFuWax0XKYSpwydqagw=
Received: by 10.223.125.145 with SMTP id y17mr198526far.84.1286614119767;
        Sat, 09 Oct 2010 01:48:39 -0700 (PDT)
Received: from localhost.localdomain (abwr119.neoplus.adsl.tpnet.pl [83.8.241.119])
        by mx.google.com with ESMTPS id e17sm2045583faa.39.2010.10.09.01.48.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 01:48:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o998mBTa017738;
	Sat, 9 Oct 2010 10:48:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o998m13E017711;
	Sat, 9 Oct 2010 10:48:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <86k4lteow6.fsf@peer.zerties.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158576>

Christian Dietrich <stettberger@dokucode.de> writes:

> I wanted to announce my project metagit[1], which I started a few weeks
> ago. It is a python program, which allows you to manage many scm
> repositories at once, e.g. pull all repositories, that are matched by a
> given regex. Before you can use it you have to define a set of
> repositories. This can either be accomplished by defining them one by
> one, or you can use a repo lister. 
[...]

> [1] http://github.com/stettberger/metagit

Could you add short description about this project in appriopriate place
on https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
page?

Thanks in advance.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
