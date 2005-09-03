From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PROBLEM] Checkout from cloned repository does not work
Date: Sat, 03 Sep 2005 10:43:02 +0300
Message-ID: <1125733383.29087.8.camel@localhost>
References: <84144f0205090204201f74e425@mail.gmail.com>
	 <7vpsrrgwxb.fsf@assigned-by-dhcp.cox.net>
	 <1125730179.29087.3.camel@localhost>
	 <7vmzmua9ow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 09:45:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBSgu-0000jc-Q3
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 09:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVICHng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 03:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVICHng
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 03:43:36 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22932 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751194AbVICHng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 03:43:36 -0400
Received: from hki2-5-1-87.hoasnet.inet.fi (hki2-5-1-87.hoasnet.inet.fi [80.221.48.135])
  (AUTH: LOGIN penberg, SSL: TLSv1/SSLv3,128bits,RC4-MD5)
  by mail.cs.helsinki.fi with esmtp; Sat, 03 Sep 2005 10:43:34 +0300
  id 0008FE67.43195426.0000337C
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzmua9ow.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8038>

On Sat, 2005-09-03 at 00:31 -0700, Junio C Hamano wrote:
> Which ended with the error message "Somebody should define
> smarter http server protocol".  That's from git-clone-script and
> the echo to generate the output is followed by "exit 1".

Oh, I just didn't realize that was an error message. Perhaps it could
have an "Error" prefix and an explanation that the repository was not
cloned properly.

Anyway, thanks for the help!

			Pekka
