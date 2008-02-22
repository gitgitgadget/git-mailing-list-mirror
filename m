From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: fix In-Reply-To regression
Date: Thu, 21 Feb 2008 17:18:00 -0800
Message-ID: <7vejb5rdpz.fsf@gitster.siamese.dyndns.org>
References: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com>
 <1203639364-91817-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Uwe =?utf-8?Q?Kl?= =?utf-8?Q?eine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Len Brown <lenb@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 02:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSMYy-00031J-O8
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 02:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYBVBSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYBVBSU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 20:18:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYBVBST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 20:18:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AE542423;
	Thu, 21 Feb 2008 20:18:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1897A23F9; Thu, 21 Feb 2008 20:18:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74687>

The patch looked Ok with my initial cursory review.  Success
reports with Tested-by: would be appreciated.
