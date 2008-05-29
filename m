From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revision walking documentation: document most important
 functions
Date: Thu, 29 May 2008 16:41:17 -0700
Message-ID: <7vmym8oezm.fsf@gitster.siamese.dyndns.org>
References: <1212098185-8437-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri May 30 01:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1rlU-0005sO-MT
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 01:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYE2Xl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 19:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYE2Xl2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 19:41:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYE2Xl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 19:41:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94A4C112B;
	Thu, 29 May 2008 19:41:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E2F811129; Thu, 29 May 2008 19:41:21 -0400 (EDT)
In-Reply-To: <1212098185-8437-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Thu, 29 May 2008 23:56:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C10C075A-2DD8-11DD-A466-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83255>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Unfortunately the list is not complete, but includes the essential ones.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Thu, May 29, 2008 at 11:35:16AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not want to apply a patch _from you_ to that file unless it
>> actually
>> adds meat to the description --- I know you know git better than doing
>> just a typofix to a placeholder.
>
> Here is a start. To be honest I never used the functions I did not
> document, so I don't have too much idea what they do (not counting
> reading the source ;-) ), so I thought it's better if I leave them
> excluded from the list.
>
>> Also why did I have to fix my To: header when I tried to respond to
>> your
>> message?
>
> Hm, I sent the patch using git-send-email,...

I do not think so.  You used 

    User-Agent: Mutt/1.5.17 (2007-11-01)
