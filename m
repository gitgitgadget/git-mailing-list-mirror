From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: Remove deprecated --mixed option in
 git-reset synopsis
Date: Sat, 16 Feb 2008 12:10:21 -0800
Message-ID: <7vr6fc7jde.fsf@gitster.siamese.dyndns.org>
References: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl>
 <7vir0o90hr.fsf@gitster.siamese.dyndns.org>
 <7732B3AD-BF81-4BDD-9C9C-01A35185AE99@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Feb 16 21:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQTNU-00079w-KN
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 21:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbYBPUKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYBPUKm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 15:10:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYBPUKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 15:10:41 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E136323;
	Sat, 16 Feb 2008 15:10:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 969F66321; Sat, 16 Feb 2008 15:10:33 -0500 (EST)
In-Reply-To: <7732B3AD-BF81-4BDD-9C9C-01A35185AE99@ai.rug.nl> (Pieter de
 Bie's message of "Sat, 16 Feb 2008 20:17:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74074>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> Well, if I run it:
>
>     bash-3.2$ git reset --mixed -- NEWS
>     warning: --mixed option is deprecated with paths.

Yeah, you are right.

The patch is on 'maint' (but it will be quite a while before I
can push it out).

Thanks.
