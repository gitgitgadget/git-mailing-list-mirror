From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntax
Date: Fri, 01 Feb 2008 18:47:06 -0800
Message-ID: <7vlk646pn9.fsf@gitster.siamese.dyndns.org>
References: <7ihp802o.fsf@blue.sea.net> <ir185c73.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 03:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL8QB-000631-Nu
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbYBBCrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbYBBCrN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:47:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbYBBCrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:47:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 064EB4C4B;
	Fri,  1 Feb 2008 21:47:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 437454C4A;
	Fri,  1 Feb 2008 21:47:08 -0500 (EST)
In-Reply-To: <ir185c73.fsf@blue.sea.net> (Jari Aalto's message of "Sat, 02 Feb
	2008 04:22:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72213>

You know that I am not taking patches that are not fixes this
deep into the release freeze, don't you?

I do not take patches early, and certainly I'll not take a patch
that changes a single page to make it the _first and only_ user
of the convention to use curly brace to delimit required
alternates.  It means now the whole manual set is less
consistent.

Please let the discussion brew for a while, and after reaching a
consensus on the list, send in a patch that changes parentheses
to curly braces for _ALL_ manual pages (and does nothing else).
