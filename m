From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 00:30:09 -0700
Message-ID: <7v4pk3bi7y.fsf@assigned-by-dhcp.cox.net>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 09:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAhVf-0002UN-NR
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXGQHaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbXGQHaL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:30:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33457 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXGQHaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 03:30:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717073010.ADB1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 03:30:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QXW91X00E1kojtg0000000; Tue, 17 Jul 2007 03:30:09 -0400
In-Reply-To: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
	(Thomas Glanzmann's message of "Mon, 16 Jul 2007 19:12:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52744>

Thanks.
