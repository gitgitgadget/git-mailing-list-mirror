From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Wed, 12 Mar 2008 22:36:05 -0700
Message-ID: <7v4pbb18ze.fsf@gitster.siamese.dyndns.org>
References: <20080313052713.GU8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 06:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZg7b-0007M8-Kw
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 06:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYCMFgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYCMFgN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 01:36:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYCMFgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 01:36:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BAEA514FE;
	Thu, 13 Mar 2008 01:36:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1D88B14FD; Thu, 13 Mar 2008 01:36:08 -0400 (EDT)
In-Reply-To: <20080313052713.GU8410@spearce.org> (Shawn O. Pearce's message
 of "Thu, 13 Mar 2008 01:27:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77035>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'm nearing the point where I want to cut a 0.10.0 tag, as Junio
> is looking to do 1.5.5-rc0/1 in the near future.
>
> I've been busy on jgit/egit lately, and day-job, so I haven't
> done any major feature development on git-gui in a few weeks.
> Its basically in feature freeze at this point.
>
> If you get a chance, please review your translations and send a
> patch if there are any updates.
>
> Current status of my master branch:
>
>     MSGFMT    po/de.msg 386 translated.
>     MSGFMT    po/fr.msg 371 translated.
>     MSGFMT    po/hu.msg 371 translated.
>     MSGFMT    po/it.msg 390 translated, 1 untranslated.
>     MSGFMT    po/ja.msg 371 translated.
>     MSGFMT    po/ru.msg 367 translated, 4 untranslated.
>     MSGFMT    po/sv.msg 371 translated.
>     MSGFMT po/zh_cn.msg 368 translated, 2 fuzzy, 1 untranslated.

Just curious.  Why do these languages have different totall number of
messages?
