From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] whitespace: more accurate initial-indent highlighting
Date: Mon, 17 Dec 2007 16:51:02 -0800
Message-ID: <7v3au04yh5.fsf@gitster.siamese.dyndns.org>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
	<1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-3-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-4-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-5-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
	<ACA0791E-189F-4E19-AE87-C7D1163C0366@wincent.com>
	<7vwsrdd9wa.fsf@gitster.siamese.dyndns.org>
	<m3y7bsq1vo.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QgX-0005ii-Of
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbXLRAvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbXLRAvW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:51:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbXLRAvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:51:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4C94443;
	Mon, 17 Dec 2007 19:51:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C06E4442;
	Mon, 17 Dec 2007 19:51:10 -0500 (EST)
In-Reply-To: <m3y7bsq1vo.fsf@roke.D-201> (Jakub Narebski's message of "Mon, 17
	Dec 2007 16:32:09 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68677>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, does "trailing empty lines at the end of file" whitespace
> error get detected and hightlighted with refactored whitespace checking?

Did you read the whole thread yet?
