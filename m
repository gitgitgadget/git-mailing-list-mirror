From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prompt to continue when editing during rebase
 --interactive
Date: Wed, 27 Feb 2008 11:48:44 -0800
Message-ID: <7v8x16tc2r.fsf@gitster.siamese.dyndns.org>
References: <57518fd10802270450r27e7339cs7612eab733d4e94e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSIi-00063F-2k
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147AbYB0Tsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbYB0Tsy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:48:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757086AbYB0Tsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:48:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CAA99251A;
	Wed, 27 Feb 2008 14:48:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 292722517; Wed, 27 Feb 2008 14:48:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75296>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> On hitting an edit point in an interactive rebase, git should prompt
> the user to run "git rebase --continue"

Yeah, this was suggested on the list earlier, we had a couple of
comments but overall I think the consensus was favorable.

Thanks.
