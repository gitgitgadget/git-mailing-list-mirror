From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [ is explicitly disallowed by bad_ref_char
Date: Fri, 23 May 2008 10:58:03 -0700
Message-ID: <7vlk20sy1g.fsf@gitster.siamese.dyndns.org>
References: <a4cc77ec0805230142n7dda9f7ahe4bde3b80f369220@mail.gmail.com>
 <20080523103906.GO27724@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Paul Oliver <puzza007@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 19:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzbXw-0005MX-RT
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 19:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYEWR6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbYEWR6N
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 13:58:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbYEWR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 13:58:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C0BC46C0;
	Fri, 23 May 2008 13:58:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EE6044421; Fri, 23 May 2008 13:58:05 -0400 (EDT)
In-Reply-To: <20080523103906.GO27724@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 23 May 2008 12:39:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDD13938-28F1-11DD-9FFF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82723>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, May 23, 2008 at 09:42:04AM +0100, Paul Oliver <puzza007@gmail.com> wrote:
>> ---
>>  git-cvsimport.perl |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> Could you please improve the commit message a bit? Just running git-log
> won't let to you know this patch touches git-cvsimport only, which is an
> important information here.

Also please sign-off your patch.
