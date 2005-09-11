From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Gitweb on kernel.org missing updates
Date: Sun, 11 Sep 2005 19:07:44 +1200
Message-ID: <46a038f9050911000742b6b7cb@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Sep 11 09:08:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EELwV-0007ix-8s
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 09:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVIKHH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVIKHH4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 03:07:56 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:5248 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964792AbVIKHHz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 03:07:55 -0400
Received: by rproxy.gmail.com with SMTP id i8so240596rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 00:07:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=udZoHE2LMP8W28WbZGZIws7UDQiAXWcjgaKerBKUueXIy4mFFhqRBkTckwp1GBM3GjuYHfVYlhKGfEiP0A1On7gN2gVz/WDALXnZZSyoElqMMihOf9DFAyd/Et22rKF4HIzfFJy62nXmwp3Pm6R8E+Sw+PVMCjU+17TT9GgOY/w=
Received: by 10.38.79.54 with SMTP id c54mr183940rnb;
        Sun, 11 Sep 2005 00:07:44 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 00:07:44 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8270>

I was under the impression that gitweb on kernel.org was reading from
the same repos that are published via http/rsync. I've just now
fetched a batch of updates via rsync that aren't visible on gitweb.

Is something broken in kernel.org or should I blame my ISPs proxy?

cheers,


martin
