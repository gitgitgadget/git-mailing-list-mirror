From: Junio C Hamano <gitster@pobox.com>
Subject: Re:
Date: Mon, 30 Mar 2009 01:46:18 -0700
Message-ID: <7vvdprflet.fsf@gitster.siamese.dyndns.org>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <200903300902.28821.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Mar 30 10:48:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoD9z-00039W-Ij
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039AbZC3Iq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbZC3Iq0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:46:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbZC3IqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:46:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE183AFF1;
	Mon, 30 Mar 2009 04:46:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 12CE3AFEF; Mon,
 30 Mar 2009 04:46:19 -0400 (EDT)
In-Reply-To: <200903300902.28821.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Mon, 30 Mar 2009 09:02:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3FB2BD60-1D07-11DE-A172-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115107>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> David Aguilar, 30.03.2009:
>> This is based on top of Junio's "pu" branch and is a
>> continuation of the recent difftool series.
>
> For everyone who wants to apply the patch series: Patch 5/8 depends on
> this:
>   [PATCH v2] difftool: add support for a difftool.prompt config variable
> sent about 8 minutes before this series.

Thanks for keeping an eye on this series, as a recent contributor to
mergetool.  I do not use mergetool myself, but this refactoring seems to
be a good idea in general, and help in reviewing the series is very much
appreciated.
