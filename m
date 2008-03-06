From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ISSUE] git send-email sends wrong patches and non-provided CC
 (probably bug)
Date: Thu, 06 Mar 2008 02:19:25 -0800
Message-ID: <7vskz4cfyq.fsf@gitster.siamese.dyndns.org>
References: <7bfdc29a0803060111vc98ef42q96c3ce343fef0859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDCz-0008VB-RL
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYCFKTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYCFKTk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:19:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYCFKTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:19:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BEF023B3;
	Thu,  6 Mar 2008 05:19:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A800923B0; Thu,  6 Mar 2008 05:19:33 -0500 (EST)
In-Reply-To: <7bfdc29a0803060111vc98ef42q96c3ce343fef0859@mail.gmail.com>
 (Imran M. Yousuf's message of "Thu, 6 Mar 2008 15:11:19 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76359>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> 1. git send-email sends CC to gitster though his email is not mentioned.

Check your config first.
