From: Junio C Hamano <gitster@pobox.com>
Subject: Re: add -e, was Re: What's cooking in git.git (Apr 2009, #04; Wed,
 29)
Date: Thu, 30 Apr 2009 09:04:11 -0700
Message-ID: <7v4ow686x0.fsf@gitster.siamese.dyndns.org>
References: <7vy6tivh7a.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904301125230.6621@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:05:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzYlI-0001NI-Sp
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763798AbZD3QET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763609AbZD3QES
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 12:04:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763234AbZD3QER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 12:04:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46B29130DA;
	Thu, 30 Apr 2009 12:04:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A884E130D9; Thu,
 30 Apr 2009 12:04:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904301125230.6621@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Thu, 30 Apr 2009 11:26:37 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E19F1D8-35A0-11DE-9117-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118029>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 29 Apr 2009, Junio C Hamano wrote:
>
>> * js/add-edit (Mon Apr 27 19:51:42 2009 +0200) 2 commits
>>  + t3702: fix reliance on SHELL_PATH being '/bin/sh'
>>  + git-add: introduce --edit (to edit the diff vs. the index)
>
> I think I asked if there should be a short description on top of the diff 
> you edit (just like the usage you see in rebase -i's edit script at the 
> end)... Opinions?

Nothing in particular.
