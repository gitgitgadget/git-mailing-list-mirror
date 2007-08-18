From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Sat, 18 Aug 2007 03:04:20 -0700
Message-ID: <7vmywpcg63.fsf@gitster.siamese.dyndns.org>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
	<20070816082110.GB16849@muzzle>
	<7vir7eh7mc.fsf@gitster.siamese.dyndns.org>
	<20070818090913.GA13936@soma> <85fy2hupui.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 12:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMLAU-0001a8-Bc
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 12:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbXHRKE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 06:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbXHRKE1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 06:04:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXHRKE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 06:04:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EB6E6123892;
	Sat, 18 Aug 2007 06:04:43 -0400 (EDT)
In-Reply-To: <85fy2hupui.fsf@lola.goethe.zz> (David Kastrup's message of "Sat,
	18 Aug 2007 11:57:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56108>

David Kastrup <dak@gnu.org> writes:

> git-svn makes it possible for me to keep the mess that is git to
> myself, and only expose others to the _results_ of my work with it.

Very well put.  It is not just svn but I privately use git on
top of cvs managed project for exactly this reason.
