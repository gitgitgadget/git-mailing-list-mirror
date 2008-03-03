From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove unused sh functions from git-mergetool.sh
Date: Mon, 03 Mar 2008 15:33:10 -0800
Message-ID: <7vd4qbfknd.fsf@gitster.siamese.dyndns.org>
References: <20080303221817.GA7410@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWKAQ-0001Vd-Lv
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbYCCXdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756322AbYCCXdT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:33:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180AbYCCXdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:33:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62F7320C7;
	Mon,  3 Mar 2008 18:33:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D5B5D20C6; Mon,  3 Mar 2008 18:33:13 -0500 (EST)
In-Reply-To: <20080303221817.GA7410@hashpling.org> (Charles Bailey's message
 of "Mon, 3 Mar 2008 22:18:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75998>

Charles Bailey <charles@hashpling.org> writes:

> This patch belongs on top of the mergetool updates in pu. It removes a
> couple of shell functions which were made redundant in commit
> 6fef6e2...  In fact it should logically be squashed into that commit.

Will do.  Thanks.
