From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v3] renaming quote_path() as quote_path_relative()
Date: Sat, 08 Mar 2008 12:31:10 -0800
Message-ID: <7vabl9t0tt.fsf@gitster.siamese.dyndns.org>
References: <7vbq5r5czw.fsf@gitster.siamese.dyndns.org>
 <1205004816-28301-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 21:32:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5i1-0002kn-VT
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYCHUbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbYCHUbT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:31:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYCHUbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:31:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA5DC3C27;
	Sat,  8 Mar 2008 15:31:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 414713C25; Sat,  8 Mar 2008 15:31:13 -0500 (EST)
In-Reply-To: <1205004816-28301-1-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Sat, 8 Mar 2008 22:33:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76580>

I think our mails and works crossed.  Please check what is in 'next',
where I already applied the previous ones with trivial fix-ups and an
additional test.
