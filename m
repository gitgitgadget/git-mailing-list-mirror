From: Junio C Hamano <gitster@pobox.com>
Subject: Pending changes before 1.8.3-rc2?
Date: Fri, 10 May 2013 11:38:07 -0700
Message-ID: <7vwqr6znn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Eric Wong <normalperson@yhbt.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 20:38:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UasD2-0005jy-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab3EJSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:38:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089Ab3EJSiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:38:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F405E1D7BB;
	Fri, 10 May 2013 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	qsOg9BcCHI6N3ubcFFFaRot5Fk=; b=g+m9XbTQyf7boh+lGUZeENNFQjWFaKLbl
	vZtzScYM4AQTOMPTfD5reQke/uP5gu73VzQEnJUmWmg7k0OQYdqzBKSglJtmE2jC
	s3BwpWKiZ1BZJkXSOtKFWzlIqLqV82wzImDSDXazIA0gthQND9fiKNgmoOZrZ8bf
	Add46uXmeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=QHZig1rdJ3AM5gN7f15lQOFKByBkUPrJosq3GuUcizblHAlRnwOQ3own
	krk0CELVgArYTO96tGROIeAlg398NYdH2QZjq3dCE2woJfjKGdEB2/WgX8zm3MVt
	UPzmusTtQStyjIa549vx3RVD0yrXR9JemyJzK1FLo3QdHqdqRXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F491D7BA;
	Fri, 10 May 2013 18:38:08 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 641871D7B8;
	Fri, 10 May 2013 18:38:08 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C294EC1E-B9A0-11E2-B68F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223892>

I should learn to start bugging you folks a lot earlier in the
release cycle (except for Jiang, as localization strings will not be
finalizable until very late), but anyway, we will soon be tagging
the hopefully final -rc for the upcoming release.  Please throw me a
"pull this now!" if you have stuff that needs to be in 1.8.3.

Thanks.

 
