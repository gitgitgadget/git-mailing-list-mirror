From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gittor: Project initiated
Date: Fri, 19 Feb 2010 09:47:18 -0800
Message-ID: <7vk4u9m82h.fsf@alter.siamese.dyndns.org>
References: <e72faaa81002190836i5e9610dfx1728b50646d8c2cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:47:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiWx1-0005LH-PN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab0BSRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:47:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0BSRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:47:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD8B29B335;
	Fri, 19 Feb 2010 12:47:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+GyEc8N4oEeg1cR3RbG2//+Nw8=; b=rNxyKN
	+U0N9EQx7LOvxT6jdQMIYW7CCx0txVfi3L/UCw+h7P0CSWCXypLrSSNIT5ESZW+N
	K+iHaX4FGEOU6kYCgqdt3gGeF7YZ4291bWJygmC+E+7fsoCgJwYS7R5hHKcDvkCY
	3fqWrETSLCWh5KX9AnohEHKdCxL1XPeXW0Fog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBA1C3b7469SxsT782iGBA67SSMTyJaA
	bcGDE84/fOpDmEachxUa6t+o8QKEJZBOtYtZI44B0nJJbD2Em5zyIUV6Y9feXlMS
	RNPdOfpZWtXLX/HvuXUr0yuTYChE0qZGVQ1ao1BvkmHuXXCLqFEskpkD5b0lV5gX
	KDXQhRKPxFk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76E769B330;
	Fri, 19 Feb 2010 12:47:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 620F69B32F; Fri, 19 Feb
 2010 12:47:21 -0500 (EST)
In-Reply-To: <e72faaa81002190836i5e9610dfx1728b50646d8c2cb@mail.gmail.com>
 (Pavan Kumar Sunkara's message of "Fri\, 19 Feb 2010 22\:06\:08 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D82F5A12-1D7E-11DF-B47A-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140470>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

>   I am Pavan Kumar Sunkara who proposed a project for writing a web
> based GUI client for git.

I was excited to see the Subject: line and was made into thinking it has
something to do with git and tor(rent), and then reading the first few
lines made me somewhat dissapointed to find out it was a web thingy
instead.

Not that I have anything against having a web-GUI, but I think the name is
misleading.
