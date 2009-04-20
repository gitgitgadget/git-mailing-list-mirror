From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 04/12] send-email: Verification for --smtp-server
 and --smpt-server-port
Date: Sun, 19 Apr 2009 19:38:51 -0700
Message-ID: <7vzlecm4lg.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <7vzlecnlsh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:40:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvjQv-0002q6-2m
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 04:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZDTCi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 22:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZDTCi5
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 22:38:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbZDTCi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 22:38:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27A4D10107;
	Sun, 19 Apr 2009 22:38:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8F6AD10104; Sun,
 19 Apr 2009 22:38:52 -0400 (EDT)
In-Reply-To: <7vzlecnlsh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Apr 2009 18:42:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 645599F0-2D54-11DE-97BC-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116927>

Junio C Hamano <gitster@pobox.com> writes:

> Please stop placing a false blame on others.  I think it is you who lack
> ability to read the documentation correctly in this particular case.

Sorry, this came out stronger than I intended.  Your ability has never
been an issue (otherwise there wouldn't have been this patch series).  I
think you just did not read the documentation carefully enough in this
case.
