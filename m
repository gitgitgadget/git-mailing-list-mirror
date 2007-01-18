From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:57:17 +0100
Message-ID: <87y7o0mzcy.fsf@wine.dyndns.org>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<87ps9d7j6t.fsf@morpheus.local>
	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	<7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 10:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7U1Q-0007RE-W0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 10:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXARJ5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 04:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXARJ5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 04:57:25 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:43727 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbXARJ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 04:57:24 -0500
Received: from adsl-89-217-12-128.adslplus.ch ([89.217.12.128] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H7U1I-0006sB-Ha; Thu, 18 Jan 2007 03:57:21 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 15B044F8E3; Thu, 18 Jan 2007 10:57:18 +0100 (CET)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> (Alex Riesen's message of "Thu\, 18 Jan 2007 08\:59\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37073>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Also, how many mail clients know that .patch is actually
> a text and not application/binary? It'll make patch
> reviewing harder for some (not sure if I'd like a review
> of such a person, though).

OTOH such mail clients usually also think they can freely reformat
text files, leading to unusable patches.  A .patch extension would
help avoid that type of breakage, so I think it's a good idea.

-- 
Alexandre Julliard
julliard@winehq.org
