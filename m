From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Wed, 21 Nov 2007 15:32:19 +0100
Message-ID: <vpqr6ijfz4c.fsf@bauges.imag.fr>
References: <1195655278-19535-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuqeF-0006ww-WB
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbXKUOdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbXKUOdf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:33:35 -0500
Received: from imag.imag.fr ([129.88.30.1]:35986 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbXKUOde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:33:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lALEWK7F000914
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Nov 2007 15:32:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iuqcm-0006DA-1E; Wed, 21 Nov 2007 15:32:20 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iuqcl-0004ai-V7; Wed, 21 Nov 2007 15:32:19 +0100
In-Reply-To: <1195655278-19535-1-git-send-email-win@wincent.com> (Wincent Colaiuta's message of "Wed\, 21 Nov 2007 15\:27\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 21 Nov 2007 15:32:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65654>

Wincent Colaiuta <win@wincent.com> writes:

> +		   [ 'update', \&update_cmd, '[u]date', ],
                                                 ^
"p" missing in "update".

-- 
Matthieu
