From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 03:12:15 -0500
Message-ID: <5370825f709ef_a8114c1304e2@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <CA+55aFwf9iAKxbvdPV9Up_T709KwBXJWW4g-F829CRQP4YkivQ@mail.gmail.com>
 <53707b5955034_2b5710592f8aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Dusty Phillips <dusty@linux.ca>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Christophe Simonis <christophe@kn.gl>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 10:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjlW0-0000t6-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 10:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbaELIXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 04:23:11 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42476 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbaELIXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 04:23:09 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so7790914obc.9
        for <git@vger.kernel.org>; Mon, 12 May 2014 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=aDh0O92RWCjCwAKczWVvCUETfgHlR9NYO0Z7E4zcPOM=;
        b=wBRT5ysiCpbRLvR+zVuWf/wYfMH9WVBXeNTegkKBoCPL2XbRuZST7QXocl03J7420n
         bshLVRYZPJKf/Dj+zGwBc4ik3D0ZHMrJ2yiKTy1WRYR3SUQiBheE7xT7L2q3ZkMGJifw
         VHK9aIFeQUopv9du/WtI78EaGWzp3qa3M+Dik0EAw0mpTmkM0XPQPkg2wy3kDQwZmbTt
         NItB0EeKYtNhjaqNEbacFBSsoY1sOVdgXlye7kdpPgTMYGme/8y2OZD5OPieOtUXokIQ
         Sd5j+VpDFICKBTjh+1oA3eLl1YzOKrZppLFhKM6++rL8JnTUxY/pUffGqVvgNw5M+X1a
         OTcg==
X-Received: by 10.182.236.229 with SMTP id ux5mr31633638obc.12.1399882989085;
        Mon, 12 May 2014 01:23:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm46672164oeb.9.2014.05.12.01.23.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 01:23:08 -0700 (PDT)
In-Reply-To: <53707b5955034_2b5710592f8aa@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248692>

Felipe Contreras wrote:
> Linus Torvalds wrote:
> > Felipe, stop this stupid blaming of everybody but yourself.
> 
> Show me evidence that this decision was my fault. Junio certainly hasn't
> said so. You just have no idea what we are talking about.

Here, let me show you.

Junio, can you answer these questions?

 1) What is missing from git-remote-hg/bzr in order for them to be
    considered to be merged to the core?

 2) If a different maintainer steps up, would you consider reconsider
    merging them to the core?

 3) Is there any chance that in the future you would consider them after
    they are more mature, and/or perhaps with a different maintainer?

Unless Junio changes his mind again, the answers to those questions
should be clear already to the people following the discussion
(i.e. not you).

-- 
Felipe Contreras
