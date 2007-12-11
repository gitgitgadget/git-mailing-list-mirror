From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary mode.
Date: Tue, 11 Dec 2007 14:21:05 -0800
Message-ID: <7vlk80dga6.fsf@gitster.siamese.dyndns.org>
References: <20071211092916.GF30948@artemis.madism.org>
	<m3ve75sfn3.fsf@roke.D-201>
	<20071211115914.GJ30948@artemis.madism.org>
	<20071211122539.GA13945@sigill.intra.peff.net>
	<20071211140508.GA12204@elte.hu>
	<20071211144351.GA15448@artemis.madism.org>
	<20071211145709.GB19427@elte.hu>
	<20071211152412.GB15448@artemis.madism.org>
	<20071211154841.GA29805@elte.hu>
	<20071211160744.GE15448@artemis.madism.org>
	<20071211211341.GB6902@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DVd-0005DC-PW
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbXLKWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756033AbXLKWV0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:21:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998AbXLKWVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:21:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51CDC56B8;
	Tue, 11 Dec 2007 17:21:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 196DC56B3;
	Tue, 11 Dec 2007 17:21:06 -0500 (EST)
In-Reply-To: <20071211211341.GB6902@elte.hu> (Ingo Molnar's message of "Tue,
	11 Dec 2007 22:13:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67958>

Ingo Molnar <mingo@elte.hu> writes:

> * Pierre Habouzit <madcoder@debian.org> wrote:
>
>> The next git has a _lot_ of things done better wrt UI and such issues. 
>> Though some backward incompatible changes must be introduced with the 
>> proper deprecation warnings, so that people can adapt.
>
> hey, cool! Just when i decide to complain about it, after 2 years of 
> suffering, it's already fixed in the devel branch =;-)

Heh, as I saw you post "diff --git" patches to the kernel mailing list
and heard nothing from you for the last two years here, I naturally
assumed you were one of the many people who were perfectly happy with
git.

Please direct more complaints to this list, not to the kernel list nor
elsewhere ;-).
