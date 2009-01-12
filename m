From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: add --authors-file test
Date: Sun, 11 Jan 2009 21:40:03 -0800
Message-ID: <7vwsd1jd58.fsf@gitster.siamese.dyndns.org>
References: <20090111234406.GA22763@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMFYO-0000wU-B1
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbZALFkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbZALFkN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:40:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZALFkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:40:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BAF01C4AA;
	Mon, 12 Jan 2009 00:40:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 414B31C4A7; Mon,
 12 Jan 2009 00:40:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 791A31D8-E06B-11DD-9EBD-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105293>

Eric Wong <normalperson@yhbt.net> writes:

> I'm not sure how often this functionality is used, but in case
> it's not, having an extra test here will help catch breakage
> sooner.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>
>   This was posted over a year ago and forgotten about.  Updated and
>   cleaned up a bit to work with the new test suite.

Thanks.
