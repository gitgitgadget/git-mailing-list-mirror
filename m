From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Thu, 06 Aug 2009 20:55:13 -0700
Message-ID: <7v3a848ehq.fsf@alter.siamese.dyndns.org>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org>
 <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <20090807123346.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZGYJ-0003ey-W3
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 05:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbZHGDz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 23:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757028AbZHGDz0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 23:55:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995AbZHGDzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 23:55:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EE3323103;
	Thu,  6 Aug 2009 23:55:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF51F23100; Thu, 
 6 Aug 2009 23:55:16 -0400 (EDT)
In-Reply-To: <20090807123346.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 07 Aug 2009 12\:33\:46 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2245E67A-8306-11DE-A71A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125171>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> And Nicolas Sebrecht has been working with Junio to implement an
> enhancement to add support for the "individual piece of email" format.

I'll squash patches 1+2/3 from Brandon into a single change after
retitling it to read "am" not "mailinfo", and queue the result, together
with patch 3/3.

Thanks, Brandon and Nicolas.
