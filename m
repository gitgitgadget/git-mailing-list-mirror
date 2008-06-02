From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a --dry-run option to git-svn rebase
Date: Sun, 01 Jun 2008 22:37:20 -0700
Message-ID: <7v7id89z3j.fsf@gitster.siamese.dyndns.org>
References: <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com>
 <1211254157-41316-1-git-send-email-seth@userprimary.net>
 <20080530171831.GB76080@ziti.local> <20080601101304.GC16064@hand.yhbt.net>
 <20080602045639.GB647@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Seth Falcon <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K32kU-00066E-9T
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbYFBFhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 01:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYFBFhe
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 01:37:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYFBFhd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 01:37:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 295023964;
	Mon,  2 Jun 2008 01:37:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6FBE33963; Mon,  2 Jun 2008 01:37:26 -0400 (EDT)
In-Reply-To: <20080602045639.GB647@ziti.local> (Seth Falcon's message of
 "Sun, 1 Jun 2008 21:56:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF272F62-3065-11DD-90C4-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83492>

Seth Falcon <seth@userprimary.net> writes:

> * On 2008-06-01 at 03:13 -0700 Eric Wong wrote:
>> This patch looks reasonable to me.
>> Acked-by: Eric Wong <normalperson@yhbt.net>
>
>> One minor nit is 'url' not being capitalized in the output.
>> Perhaps:
>
> Any of the suggested bike shed colors are fine by me :-) I'll assume
> the patch is fine as-is, or will be edited by Junio before being
> applied, unless I hear otherwise.

Yeah, I've queued the patch.  Thanks, both.
