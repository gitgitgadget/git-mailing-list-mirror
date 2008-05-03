From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] diff.c: Use show variable name in
 fn_out_diff_words_aux
Date: Sat, 03 May 2008 10:47:08 -0700
Message-ID: <7vbq3nuvoj.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 19:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLqH-0005Nt-Bg
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbYECRrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYECRrZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:47:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYECRrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 13:47:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A651F2A3E;
	Sat,  3 May 2008 13:47:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 061512A38; Sat,  3 May 2008 13:47:16 -0400 (EDT)
In-Reply-To: <1209815828-6548-3-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Sat, 3 May 2008 19:57:05 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBF09FAC-1938-11DD-BB28-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81105>

Cannot parse the summary line.  Try again.
