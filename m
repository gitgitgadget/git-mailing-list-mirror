From: Uri Okrent <uokrent@gmail.com>
Subject: Re: Auto-refresh git-gui
Date: Tue, 10 Jan 2012 18:14:04 +0200
Message-ID: <CALPkawZR6PU5wNrdG03L9iAk85K4ZEFakF5oQK2fqdqWUMjJzA@mail.gmail.com>
References: <20120104091547.GC3484@victor> <20120104163338.GA27567@ecki.lan> <20120105080322.GD3484@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: victor.engmark@terreactive.ch
X-From: git-owner@vger.kernel.org Tue Jan 10 17:14:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeLW-0004TR-SR
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab2AJQO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 11:14:27 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34947 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab2AJQO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 11:14:26 -0500
Received: by vbbfc26 with SMTP id fc26so3621690vbb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mIX1WAwQQxgPi1W3rI+cZnRxukSMz8ZUtGyw0U1zBVg=;
        b=kPA5LXzD+yMZjozq+ZGsBiCqlnIz6WB0SbH0ZQGDDMrXl45T5UwV2YLsh7O9q58LB2
         ExY6Hdm71nS1vtA8B8Ivgev77b6muRven5xvOVNAde85IFzMAn3YkXjIZQP47YQzd9Bj
         1mXyGQRfPmGsS8c8kFcNE4CBu0eN/T0lmSoys=
Received: by 10.52.21.129 with SMTP id v1mr9650504vde.78.1326212065222; Tue,
 10 Jan 2012 08:14:25 -0800 (PST)
Received: by 10.52.169.101 with HTTP; Tue, 10 Jan 2012 08:14:04 -0800 (PST)
In-Reply-To: <20120105080322.GD3484@victor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188255>

Not to muddy the waters, but if you're open to alternatives, if you
have inotify installed, git cola will automatically update it's status
whenever files in your repository change.
--=20
=C2=A0=C2=A0 Uri

Please consider the environment before printing this message.
http://wwf.panda.org/savepaper/
