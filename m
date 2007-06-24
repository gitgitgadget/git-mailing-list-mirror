From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sun, 24 Jun 2007 15:18:52 -0700
Message-ID: <7v8xa9q9mb.fsf@assigned-by-dhcp.cox.net>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
	<Pine.LNX.4.64.0706240109540.4059@racer.site>
	<31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
	<7vbqf5wtrb.fsf@assigned-by-dhcp.cox.net>
	<31e9dd080706241031m64c6be37sb4437036fda543c9@mail.gmail.com>
	<31e9dd080706241440s21025c26p68fda1595d531f1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aQ4-00030K-Af
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXFXWSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbXFXWSy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:18:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37403 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXFXWSy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:18:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624221853.NIZT3339.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 18:18:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FaJt1X0021kojtg0000000; Sun, 24 Jun 2007 18:18:53 -0400
In-Reply-To: <31e9dd080706241440s21025c26p68fda1595d531f1e@mail.gmail.com>
	(Jason Sewall's message of "Sun, 24 Jun 2007 14:40:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50828>

"Jason Sewall" <jasonsewall@gmail.com> writes:

> I'd suggest that we put all inline revspecs inside $$...$$; this
> "inline passthrough" quote  obeys outside quoting,...

Does that work with AsciiDoc 7?

> Is there a documentation 'style' file or something like that for git?

Well, there isn't one as nobody really knows AsciiDoc well
enough, and actually my message was to con you into writing one ;-).
