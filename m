From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: re-enable 'status' as the default subcommand
Date: Fri, 17 Aug 2007 01:10:42 -0700
Message-ID: <7vmywqh98d.fsf@gitster.siamese.dyndns.org>
References: <11862375532593-git-send-email-hjemli@gmail.com>
	<8c5c35580708170025g70db9f3eu664551400e9430d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, skimo@kotnet.org
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Fri Aug 17 10:11:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILwve-00028b-Te
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 10:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758876AbXHQIKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 04:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758630AbXHQIKx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 04:10:53 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762200AbXHQIKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 04:10:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D950A12098F;
	Fri, 17 Aug 2007 04:11:06 -0400 (EDT)
In-Reply-To: <8c5c35580708170025g70db9f3eu664551400e9430d4@mail.gmail.com>
	(Lars Hjemli's message of "Fri, 17 Aug 2007 09:25:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56051>

"Lars Hjemli" <lh@elementstorage.no> writes:

> I got no response on this patch, was it simply overlooked? I really think
>
> $ git submodule
>
> should show the available submodules and their status.

Probably.  I do not think of any other alternative behaviour
that would make sense.

Sven?
