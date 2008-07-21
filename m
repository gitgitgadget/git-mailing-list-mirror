From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library
 1.5.0
Date: Sun, 20 Jul 2008 18:54:12 -0700
Message-ID: <7vvdz0ypbv.fsf@gitster.siamese.dyndns.org>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
 <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org>
 <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com>
 <7vbq0tibuf.fsf@gitster.siamese.dyndns.org>
 <20080720201407.GM2925@dpotapov.dyndns.org> <20080721012955.GA14129@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKkd4-0002To-FI
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbYGUByX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756547AbYGUByX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:54:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbYGUByW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:54:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DCD73470C;
	Sun, 20 Jul 2008 21:54:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 254503470A; Sun, 20 Jul 2008 21:54:14 -0400 (EDT)
In-Reply-To: <20080721012955.GA14129@untitled> (Eric Wong's message of "Sun,
 20 Jul 2008 18:29:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF451496-56C7-11DD-B736-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89294>

Thanks, both.
