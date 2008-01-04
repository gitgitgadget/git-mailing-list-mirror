From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 15:28:19 -0800
Message-ID: <7vd4shi31o.fsf@gitster.siamese.dyndns.org>
References: <1199426431-sup-6092@south>
	<2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Morgan <wmorgan-git@masanjin.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAvyd-0005eg-DE
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 00:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbYADX2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbYADX2e
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 18:28:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062AbYADX2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 18:28:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FCC8579F;
	Fri,  4 Jan 2008 18:28:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E66FE579E;
	Fri,  4 Jan 2008 18:28:24 -0500 (EST)
In-Reply-To: <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org> (Pedro
	Melo's message of "Fri, 4 Jan 2008 23:26:41 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69616>

Pedro Melo <melo@simplicidade.org> writes:

> Maybe I'm doing something wrong, but comparing git-add -p with your
> script, git-add -p is more darcs'ish. With git-add, if I have several
> changes in the same file, I get to choose per hunk.

Heh, thanks from somebody who did "add -i" who admits he used
darcs for a few months ;-).
