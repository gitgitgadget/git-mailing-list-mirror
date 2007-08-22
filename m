From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Wed, 22 Aug 2007 14:34:51 -0700
Message-ID: <7vir77i77o.fsf@gitster.siamese.dyndns.org>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle>
	<8b65902a0708220307g2cb4b290s9bbf4603af7489fa@mail.gmail.com>
	<8b65902a0708220317t2b3dd01csef460a943ed2ef37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Richard MUSIL" <richard.musil@st.com>, git@vger.kernel.org
To: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxrH-0007xI-Uz
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764167AbXHVVfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763831AbXHVVfG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:35:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760460AbXHVVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 17:35:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C926126687;
	Wed, 22 Aug 2007 17:35:20 -0400 (EDT)
In-Reply-To: <8b65902a0708220317t2b3dd01csef460a943ed2ef37@mail.gmail.com>
	(Guilhem Bonnefille's message of "Wed, 22 Aug 2007 12:17:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56424>

"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com> writes:

> Oops, sory, I'm completly wrong: the git-svn-id is put on the commit
> log in the Git repo, not on the SVN repo.
> Please, ignore me.

I do not think it is wrong to tack that to the commit message
you push it back to SVN... am I missing something?
