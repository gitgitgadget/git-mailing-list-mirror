From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9700/test.pl: backwards compatibility improvements
Date: Wed, 23 Jul 2008 16:33:00 -0700
Message-ID: <7vtzeg89cj.fsf@gitster.siamese.dyndns.org>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <k-pcfapbFwwISYvjf34W3d-E7j-DCb9tf-MW1z8rFObaPKgPJEmD7Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnqT-0006Rc-Kl
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYGWXdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbYGWXdI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:33:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbYGWXdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:33:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4997C3836B;
	Wed, 23 Jul 2008 19:33:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 831C038369; Wed, 23 Jul 2008 19:33:02 -0400 (EDT)
In-Reply-To: <k-pcfapbFwwISYvjf34W3d-E7j-DCb9tf-MW1z8rFObaPKgPJEmD7Q@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 22 Jul 2008 16:16:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2F6939E-590F-11DD-BCBF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89806>

I have applied everything except for this one.  I think it is Ok, but
let's hear success or breakage stories from the list first and then remind
me if the patch seems Ok, please?
