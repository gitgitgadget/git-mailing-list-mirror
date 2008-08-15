From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t3700 on filesystems which do not support question
 marks in names
Date: Fri, 15 Aug 2008 02:01:01 -0700
Message-ID: <7vhc9mbqk2.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
 <7vproabvcr.fsf@gitster.siamese.dyndns.org>
 <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com>
 <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Kevin Ballard" <kevin@sb.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 11:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTvCI-0002KE-Ss
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 11:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYHOJBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 05:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbYHOJBK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 05:01:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbYHOJBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 05:01:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C26485FB9B;
	Fri, 15 Aug 2008 05:01:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 239335FB99; Fri, 15 Aug 2008 05:01:02 -0400 (EDT)
In-Reply-To: <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com>
 (Alex Riesen's message of "Fri, 15 Aug 2008 09:32:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2CD3440-6AA8-11DD-9560-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92467>

Thanks.  Applied.
