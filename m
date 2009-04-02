From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Thu, 02 Apr 2009 15:42:32 -0700
Message-ID: <7v63hmekyv.fsf@gitster.siamese.dyndns.org>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de>
 <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <GitZilla@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpVdu-0008Aa-6e
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759729AbZDBWmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 18:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758607AbZDBWmn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 18:42:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbZDBWmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 18:42:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8AB9FBCB2;
	Thu,  2 Apr 2009 18:42:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DAC84BCB1; Thu, 
 2 Apr 2009 18:42:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri, 3 Apr 2009 00:39:54 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91FFC1F8-1FD7-11DE-A5D7-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115502>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> What part of the email address is this going to lowercase? Only the domain
>> name is case agnostic.

That is my understanding of RFC, too.  Let's see where this mail goes to
find out how much more lenient the real world is ;-).
