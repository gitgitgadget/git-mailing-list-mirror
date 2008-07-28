From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Sun, 27 Jul 2008 23:44:52 -0700
Message-ID: <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMUb-0005A6-Qt
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYG1GpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYG1GpA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:45:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYG1Go7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:44:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38AAF3F58D;
	Mon, 28 Jul 2008 02:44:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 443943F58C; Mon, 28 Jul 2008 02:44:54 -0400 (EDT)
In-Reply-To: <20080728063838.GB4234@blimp.local> (Alex Riesen's message of
 "Mon, 28 Jul 2008 08:38:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B27F0522-5C70-11DD-9E1C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90422>

Alex Riesen <raa.lkml@gmail.com> writes:

> t2103-update-index-ignore-missing.sh still broken on Windows because
> of stat.st_size being 0 for directories there.

I recall we did not reach a useful conclusion of that discussion.
