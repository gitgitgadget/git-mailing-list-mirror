From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 10:15:01 -0800
Message-ID: <20091228181501.GF2252@spearce.org>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org> <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st> <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com> <20091228153701.GA2252@spearce.org> <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st> <20091228155346.GB2252@spearce.org> <be6fef0d0912280915k1320110o6a361a0950aa60f6@mail.gmail.com> <7vd41zrn4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Martin Storsj? <martin@martin.st>,
	L??na??c Huard <lenaic@lhuard.fr.eu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 19:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPKEt-0000lh-C0
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 19:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbZL1SVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 13:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZL1SVU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 13:21:20 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:37348 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZL1SVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 13:21:19 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 13:21:19 EST
Received: by gxk9 with SMTP id 9so25559421gxk.8
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 10:21:18 -0800 (PST)
Received: by 10.150.4.14 with SMTP id 14mr4626059ybd.168.1262024106638;
        Mon, 28 Dec 2009 10:15:06 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm11149654iwn.6.2009.12.28.10.15.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 10:15:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd41zrn4n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135752>

Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 -- 
> From: "Shawn O. Pearce" <spearce@spearce.org>,
> Subject: Remove http.authAny

Ack.

But I'm not sure I should be the author, you did all of the legwork
and therefore should get credit for it.  :-)

-- 
Shawn.
