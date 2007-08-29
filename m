From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3-rc7
Date: Wed, 29 Aug 2007 03:18:52 -0700
Message-ID: <7vbqcqr6cz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 12:19:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKdk-0003Y1-6S
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbXH2KTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 06:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbXH2KS7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:18:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbXH2KSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:18:55 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 65EEE128F8E
	for <git@vger.kernel.org>; Wed, 29 Aug 2007 06:19:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56929>

(oops, sent one out before finishing --- I am sitting in front
of a wrong machine and a wrong keyboard).

So I've tagged it, and this time have tarball and testing RPM at
the usual places.

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.rc7.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.rc7.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.rc7.tar.{gz,bz2}		(preformatted docs)
  testing/*-1.5.3.rc7-1.$arch.rpm		(RPM)

This time, hopefully it should be very close to final.  I still
have to help Jari whipping his last minute documentation patches
into shape, but other than that, I do not think there is
anything else that I want to delay the 1.5.3 final because of.

Please give it a gentle beating ;-).
