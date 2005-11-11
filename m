From: Paolo Teti <paolo.teti@gmail.com>
Subject: lock
Date: Fri, 11 Nov 2005 17:31:31 +0100
Message-ID: <34a7ae040511110831y3e896738o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Nov 11 17:33:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaboN-0006Sl-Ne
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKKQbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVKKQbd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:31:33 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:17467 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750844AbVKKQbc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 11:31:32 -0500
Received: by xproxy.gmail.com with SMTP id i30so755204wxd
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 08:31:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=azBYVfbVsbswZZg7peHRKiL6X4MjuBIy5xdOnqzJWN1KeJa3l+X05uMsg3hFMLzK7r7hxwg+QS8/c1JdVGxWzsdt7w5zHido3ZhK7n9GbDDSEAr4GShfRpGDc5HZihhkcx71Xk+pBQA7XmTPVW/TaR3oIrF/f+/FV6vJQqVltbs=
Received: by 10.70.115.4 with SMTP id n4mr2332445wxc;
        Fri, 11 Nov 2005 08:31:31 -0800 (PST)
Received: by 10.70.94.20 with HTTP; Fri, 11 Nov 2005 08:31:31 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11614>

Just a question probably stupid because I'm a quite new GIT user.

Is possible to apply a lock (as in ClearCase) on a given file etc in order to
prevent accidental check-out or any other tool operation?

Pao
