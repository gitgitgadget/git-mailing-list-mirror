From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 03:06:47 -0800
Message-ID: <7vk5n8b92w.fsf@gitster.siamese.dyndns.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
	<20071221104704.GC17701@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@artemis.madism.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 12:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fiy-0006UV-CC
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 12:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbXLULHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 06:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbXLULHC
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 06:07:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbXLULHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 06:07:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 129224468;
	Fri, 21 Dec 2007 06:06:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A353A4465;
	Fri, 21 Dec 2007 06:06:56 -0500 (EST)
In-Reply-To: <20071221104704.GC17701@artemis.madism.org> (Pierre Habouzit's
	message of "Fri, 21 Dec 2007 11:47:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69058>

Pierre Habouzit <madcoder@artemis.madism.org> writes:

> Hmm now I'm confused, I believed we settled for the: --abbrev 10 HEAD is
> forbidden, --abbrev=10 HEAD works, and --abbrev HEAD too.

http://thread.gmane.org/gmane.comp.version-control.git/68121/focus=68659 ?

> I'd also like to see any kind of form of gitcli(5) be merged for 1.5.4
> too, I believe the first version I ever sent. In the thread where I
> posted the proposal using `{}` the patch introducing it is the version
> formed using:

Unfortunately I've been busy lately and have already discarded
the whole series that had the {} stuff.  Could you resend
cleaned up patch please, so that I can take a look over the
weekend?
