From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 22:28:57 -0800
Message-ID: <7veiyqa8d2.fsf@gitster.siamese.dyndns.org>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by>
 <200901251521.15591.trast@student.ethz.ch> <20090125224238.GA31581@untitled>
 <497CEC56.3020900@tut.by> <20090126011847.GA8703@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: public_vi <public_vi@tut.by>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 07:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRL0k-0001yz-FC
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 07:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZAZG3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 01:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbZAZG3H
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 01:29:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZAZG3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 01:29:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B1DE1D4F3;
	Mon, 26 Jan 2009 01:29:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 37AF61D4F2; Mon,
 26 Jan 2009 01:28:59 -0500 (EST)
In-Reply-To: <20090126011847.GA8703@dcvr.yhbt.net> (Eric Wong's message of
 "Sun, 25 Jan 2009 17:18:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A067F268-EB72-11DD-8708-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107171>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks Vitaly, acked and pushed out with minor fixes to
> git://git.bogomips.org/git-svn.git

Pulled; thanks.
