From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Avoid unnecessary warning when using --all
Date: Fri, 26 Dec 2008 16:40:14 -0800
Message-ID: <7v63l6jvrl.fsf@gitster.siamese.dyndns.org>
References: <20081226220201.GA20516@spearce.org>
 <7vmyeijws2.fsf@gitster.siamese.dyndns.org>
 <20081227002627.GA21386@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNFg-00058J-Do
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYL0Ak1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYL0AkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:40:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYL0AkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:40:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BC8B78B058;
	Fri, 26 Dec 2008 19:40:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C48A98B057; Fri,
 26 Dec 2008 19:40:15 -0500 (EST)
In-Reply-To: <20081227002627.GA21386@spearce.org> (Shawn O. Pearce's message
 of "Fri, 26 Dec 2008 16:26:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0BBD74C-D3AE-11DD-A2EE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103975>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I use spearce@spearce.org for my Git work so the S-o-b line above
> is wrong.  I just fixed it in my development repository on the work
> system I used to make this patch.
>
> Having two personalities is hard...  ;-)
>
> Can you please amend to use my normal spearce@spearce.org address?

Thanks, done.
