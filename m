From: David Kastrup <dak@gnu.org>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 21:21:13 +0200
Message-ID: <87tx9ia5zq.fsf@fencepost.gnu.org>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: d9ba@mailtor.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:21:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdPDT-0004AB-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbaDXTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:21:46 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:52686 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbaDXTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:21:44 -0400
Received: from localhost ([127.0.0.1]:51725 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdPDL-0002x0-49; Thu, 24 Apr 2014 15:21:43 -0400
Received: by lola (Postfix, from userid 1000)
	id 14CE1E0995; Thu, 24 Apr 2014 21:21:13 +0200 (CEST)
In-Reply-To: <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Apr 2014 12:02:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247001>

Junio C Hamano <gitster@pobox.com> writes:

> Traditionally, because the tool grew in a context of being used in a
> project whose participants are at least not malicious, always having
> to be on the lookout for fear of middle-of-line tabs hiding bad
> contents near the right edges of lines has never been an issue.

My beef is not with "hiding bad contents" but with "hiding contents".
It makes the output useless for seeing what is actually happening as
soon as the option starts having an effect.

-- 
David Kastrup
