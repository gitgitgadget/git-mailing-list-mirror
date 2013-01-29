From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: fix broken mailing list archive link
Date: Tue, 29 Jan 2013 08:39:25 -0800
Message-ID: <7v622grlj6.fsf@alter.siamese.dyndns.org>
References: <1359456039-20562-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:39:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0EDv-000445-88
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab3A2Qja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:39:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3A2Qj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:39:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 500C2BCBB;
	Tue, 29 Jan 2013 11:39:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fSPsLWFtQ4x7QY15rnIkPoOtyyk=; b=gh5hRJ
	sIIXUUjUbvrLGR+DloAUVov7c/s6dG7sPzFwYe7s/QUwDxOSmvHCmlCa+aRqv6c9
	Mns1wN3lzBJmCqvMIMIbvq/tBj7+4qQcGuF6rM8Nu7gwH89KDklXzro7TDHozu1/
	9j9sVaBhazRYsLhFUmnhI158pbKZlrfyZpJJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0Qj5FkVyMklL1ruKR+61ZhHPUGYvL7b
	mjajA3EyfqUN1feo+vC0Ij3826YakmvdkvWLnS2l4FiqfNf1054SaDi0swGmu1XQ
	iSRDxKtyz70wUGP5SujICMaWYSuLWfRXIlpCgVCZMifwMHutlYPqEuv5I3Iu39tF
	Tb3Hw/Waiw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44583BCBA;
	Tue, 29 Jan 2013 11:39:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7256BCB9; Tue, 29 Jan 2013
 11:39:27 -0500 (EST)
In-Reply-To: <1359456039-20562-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 29 Jan 2013 16:10:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7291A620-6A32-11E2-810E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214947>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> marc.theaimsgroup.com does not exist anymore, so replace it
> with a link to the archive on GMane.

I think it has been at http://marc.info/?l=git for some time.
