From: Junio C Hamano <gitster@pobox.com>
Subject: Many things pushed out to 'master'
Date: Mon, 03 Dec 2007 02:00:02 -0800
Message-ID: <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
	<7vabosse23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 11:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz86G-0007QP-Jl
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXLCKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXLCKAI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:00:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55231 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbXLCKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:00:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8FAF12F9;
	Mon,  3 Dec 2007 05:00:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C7459B5D7;
	Mon,  3 Dec 2007 05:00:26 -0500 (EST)
In-Reply-To: <7vabosse23.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Dec 2007 18:32:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66896>

I've merged a handful topics that have been cooking in 'next' to
'master'.  Except for a few big topics still in 'next', this brings the
tip of 'master' much closer to what will become 1.5.4.

As always has been promised, the tip of 'master' is designed to be more
stable than any released version without introducing regression, and we
need to test how true that is from time to time ;-).

Please keep the fixes flowing.  The next batch will be "commit in C" and
"add --patch" series.
