From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (resend)] gitweb: Fix 'history' view for deleted files
 with history
Date: Sat, 19 Apr 2008 01:25:33 -0700
Message-ID: <7v7ieufdz6.fsf@gitster.siamese.dyndns.org>
References: <20080413121018.3951.45328.stgit@localhost.localdomain>
 <m31w52s1g7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 18:28:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8P3-0003tP-FU
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbYDSIZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 04:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYDSIZr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:25:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbYDSIZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 04:25:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF8F33D28;
	Sat, 19 Apr 2008 04:25:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 929253D27; Sat, 19 Apr 2008 04:25:40 -0400 (EDT)
In-Reply-To: <m31w52s1g7.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 19 Apr 2008 01:17:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79904>

I was in a belated merge binge tonight, and applied this to maint.  Sorry
it took too long but I have simply been very busy.
