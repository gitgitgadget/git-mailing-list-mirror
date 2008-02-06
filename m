From: Junio C Hamano <gitster@pobox.com>
Subject: Re: command prompt script for current branch
Date: Wed, 06 Feb 2008 12:42:30 -0800
Message-ID: <7vodatvmtl.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMr73-0008UE-Ud
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbYBFUmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbYBFUmt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:42:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948AbYBFUms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:42:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9A023C9;
	Wed,  6 Feb 2008 15:42:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 64DAD23C8;
	Wed,  6 Feb 2008 15:42:43 -0500 (EST)
In-Reply-To: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
	(Stephen Sinclair's message of "Wed, 6 Feb 2008 14:52:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72849>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

> ...  Sometimes I've
> found I started working only to realize I was on the wrong branch.

See contrib/completion/git-completion.bash if you are a bash user.
