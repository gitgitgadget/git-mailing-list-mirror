From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 20:50:36 +0200
Message-ID: <200708212050.37227.robin.rosenberg.lists@dewire.com>
References: <20070821124949.GH768@genesis.frugalware.org> <200708211901.55687.robin.rosenberg.lists@dewire.com> <7v1wdwpzbd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INYn0-0000B6-Nh
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 20:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760648AbXHUStP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760548AbXHUStO
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 14:49:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5462 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760594AbXHUStO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 14:49:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B01A980267F;
	Tue, 21 Aug 2007 20:41:31 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09103-03; Tue, 21 Aug 2007 20:41:31 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 58C9B80264B;
	Tue, 21 Aug 2007 20:41:31 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v1wdwpzbd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56322>

tisdag 21 augusti 2007 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > How about this instead:
> >
> > -- robin
> >
> > Include diff options into git-show command manual
> 
> I think that is probably a good idea but I wonder if placing
> diff-options in between of pretty-options and pretty-formats is
> a good idea.

Since pretty-formats is a new section in the man page it works out fine. I
actually ran make and man to verify this patch.

-- robin
