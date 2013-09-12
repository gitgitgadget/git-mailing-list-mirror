From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 17:25:02 +0200
Message-ID: <87a9jidpv5.fsf@linux-k42r.v.cablecom.net>
References: <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK8lj-0004AO-VS
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab3ILPZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:25:12 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:46693 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab3ILPZI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:25:08 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Sep
 2013 17:25:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.194) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 12 Sep 2013 17:25:05 +0200
In-Reply-To: <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Thu, 12 Sep 2013 07:15:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.194]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234654>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Also some nits.  The patch description should be imperative mood
> (cf. Documentation/SubmittingPatches).

Heh.  Serves me right to go away for a while and get SubmittingPatches
cited at me on return ;-)

Thanks for the updated patch.  I agree with the changes.  I particularly
like the better variable name.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
