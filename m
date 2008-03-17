From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 01:25:29 -0700
Message-ID: <7vr6e9bvuu.fsf@gitster.siamese.dyndns.org>
References: <20080317020304.GA19249@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Mar 17 09:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbAfp-0007uH-Kb
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 09:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYCQIZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbYCQIZo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 04:25:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbYCQIZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 04:25:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 944A62B4F;
	Mon, 17 Mar 2008 04:25:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D2F422B4E; Mon, 17 Mar 2008 04:25:38 -0400 (EDT)
In-Reply-To: <20080317020304.GA19249@diku.dk> (Jonas Fonseca's message of
 "Mon, 17 Mar 2008 03:03:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77419>

Jonas Fonseca <fonseca@diku.dk> writes:

> ... Building the documentation
> (sadly?) now depends on DocBook XSL 1.72 to reduce the number of
> accumulated AsciiDoc and XSL hacks.

Well, I've been a quiet but big fan of tig for quite some time, but to me,
requiring autoreconf is a much larger regression than DocBook dependency.
