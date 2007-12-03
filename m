From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Mon, 03 Dec 2007 18:13:33 +0100
Message-ID: <87ir3f4s76.fsf@wine.dyndns.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
	<87fxylos4o.fsf@wine.dyndns.org>
	<877ijwfh6z.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzErt-0006vn-QV
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbXLCRNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXLCRNq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:13:46 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59495 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbXLCRNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:13:45 -0500
Received: from adsl-84-227-63-16.adslplus.ch ([84.227.63.16] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IzErR-00024Z-Uz; Mon, 03 Dec 2007 11:13:44 -0600
Received: from wine.dyndns.org (localhost [127.0.0.1])
	by wine.dyndns.org (Postfix) with ESMTP id 754D01E713A;
	Mon,  3 Dec 2007 18:13:33 +0100 (CET)
In-Reply-To: <877ijwfh6z.dlv@vanicat.homelinux.org> (Remi Vanicat's message of
	"Mon, 03 Dec 2007 07:03:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66927>

Remi Vanicat <vanicat@debian.org> writes:

> Here is the corrected patch
> [...]
>
>> BTW do you have a copyright assignment for Emacs?
> No, should I seek one ?

It's not necessary right now, but I'm hoping that git.el will eventually
be merged into the main Emacs tree, and at that point we'll need a
copyright assignment from you.

> +      ["Interctive Diff File" git-diff-file-idiff t]

The typo is still here.

-- 
Alexandre Julliard
julliard@winehq.org
