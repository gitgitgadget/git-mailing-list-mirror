From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: What does this error message mean?
Date: Wed, 22 Feb 2006 00:46:37 +0200
Message-ID: <20060222004637.1a066569.tihirvon@gmail.com>
References: <200602212206.36685.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBgG1-0002ma-VX
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWBUWpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWBUWpR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:45:17 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:5317 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751201AbWBUWpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:45:16 -0500
Received: by pproxy.gmail.com with SMTP id o67so1569253pye
        for <git@vger.kernel.org>; Tue, 21 Feb 2006 14:45:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=FWC5qxToCELe2ppDhmfg1fWyK9D41aAvURKxOVTAW9ts2Itlf3w7idosaktrhPqR9TciM+YYwpGBv+jb1WvXEEfU+2KRGaddE5NtQ+J6js4GfkbTgMTCP5hY8Mb6FsBP1v1x583WmUZ8XqrVQQ4NVgn1Ujo72KtRI5+PysQrNEo=
Received: by 10.35.43.10 with SMTP id v10mr326548pyj;
        Tue, 21 Feb 2006 14:45:12 -0800 (PST)
Received: from garlic.home.net ( [82.128.201.218])
        by mx.gmail.com with ESMTP id r66sm117513pye.2006.02.21.14.45.11;
        Tue, 21 Feb 2006 14:45:12 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <200602212206.36685.alan@chandlerfamily.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16570>

On Tue, 21 Feb 2006 22:06:36 +0000
Alan Chandler <alan@chandlerfamily.org.uk> wrote:

> alan@kanger usermgr[master]$ git commit -a
> fatal: empty ident  <alan@chandlerfamily.org.uk> not allowed
> 
> Suddenly started happening, possibly after upgrade (via debian) to git 1.2.1

Your GIT_AUTHOR_NAME is empty?

-- 
http://onion.dynserv.net/~timo/
