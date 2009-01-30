From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] Missing && in t/t7001.sh.
Date: Fri, 30 Jan 2009 11:36:00 +0100
Message-ID: <vpq7i4dulm7.fsf@bauges.imag.fr>
References: =?ISO-8859-1?Q?=20<1233309819-777-?= =?ISO-8859-1?Q?1-git-send-email?=
	=?ISO-8859-1?Q?-=0E=10>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 11:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSqwK-0000Eu-IF
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 11:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbZA3KsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbZA3KsM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 05:48:12 -0500
Received: from imag.imag.fr ([129.88.30.1]:52156 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbZA3KsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 05:48:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n0UAhs7h007454
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 11:43:54 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LSqjB-0004VX-1Y; Fri, 30 Jan 2009 11:36:01 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LSqjA-00008m-VV; Fri, 30 Jan 2009 11:36:00 +0100
In-Reply-To: =?ISO-8859-1?Q?=20<1233309819-777-?= =?ISO-8859-1?Q?1-git-send-email?=
	=?ISO-8859-1?Q?-=0E=10>?= ( =?ISO-8859-1?Q?=0E=10@imag.fr's?= message of "Fri\, 30 Jan 2009 11\:03\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 30 Jan 2009 11:43:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107789>

^N^P@imag.fr writes:
^^^^

(Sorry for the bad From: header line. I must have typed something
weird at the git send-email prompt, while I thought I had just typed
"enter")

-- 
Matthieu
