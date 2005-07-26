From: Diego Calleja <diegocg@gmail.com>
Subject: Re: Linux BKCVS kernel history git import..
Date: Tue, 26 Jul 2005 21:36:43 +0200
Message-ID: <20050726213643.7ca44e96.diegocg@gmail.com>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261946AbVGZTgz@vger.kernel.org Tue Jul 26 21:41:13 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261946AbVGZTgz@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxVHh-0000hQ-4G
	for glk-linux-kernel@gmane.org; Tue, 26 Jul 2005 21:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVGZTgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 26 Jul 2005 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGZTgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:36:54 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:55665 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261886AbVGZTgu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:36:50 -0400
Received: by zproxy.gmail.com with SMTP id i11so22195nzh
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2005 12:36:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZOJRCJxVnNtESI2lcs+EbFxovbOM26DJk/BS6ZZ5v7EzyG5lwqSuT0U3eXeUD8KWYy3M5J5jB57sHPaOBeHbUTpRgeV/DwCmE7zCUz7oeD5vD8fdIe4iJyY14Wn0glsMTI3mO0PBEusknIcxctrzWwYCfXp8kedBZyjffD+JF/U=
Received: by 10.36.8.10 with SMTP id 10mr113965nzh;
        Tue, 26 Jul 2005 12:36:46 -0700 (PDT)
Received: from estel ([80.103.39.111])
        by mx.gmail.com with ESMTP id 23sm51268nzn.2005.07.26.12.36.43;
        Tue, 26 Jul 2005 12:36:46 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.8; i686-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Jul 2005 11:57:43 -0700 (PDT),
Linus Torvalds <torvalds@osdl.org> escribi=F3:

> I'm planning on doing the 2.4 tree too some day - either as a separat=
e
> branch in the same archive, or as a separate git archive, I haven't q=
uite

It'd be great  to have the same thing but for the 1.0 - 2.2 tree. Of co=
urse
there are no "changelogs" for that, but incremental patches are still
available, and it'd be very interesting (for "historical reasons") to s=
ee how
things were added/removed
