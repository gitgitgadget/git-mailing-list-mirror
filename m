From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to configure the color of git diff outpyut
Date: Fri, 17 Jul 2009 09:51:46 -0700
Message-ID: <7vbpnj5k2l.fsf@alter.siamese.dyndns.org>
References: <3b9893450907170935k53baf50fue84fe619624a4489@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: n179911 <n179911@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:52:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRqf9-0001b7-Gq
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934743AbZGQQvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbZGQQvx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:51:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934734AbZGQQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 12:51:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C80267E6E;
	Fri, 17 Jul 2009 12:51:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 966CC7E68; Fri, 17 Jul 2009
 12:51:48 -0400 (EDT)
In-Reply-To: <3b9893450907170935k53baf50fue84fe619624a4489@mail.gmail.com>
 (n179911@gmail.com's message of "Fri\, 17 Jul 2009 09\:35\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 203E2172-72F2-11DE-8E29-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123477>

n179911 <n179911@gmail.com> writes:

> When I do git diff, for example, it has color output (red for "-" and
> green for "+").
> Can you please tell me how can I change the color used?

Can you please tell us what resources you consulted to figure this out
yourself before asking your question on this list?  I am not complaining;
I am trying to see how a "typical" user finds information on our software,
so that we can potentially optimize our documentation set to make it
easier to find answers to common questions.

The answer to your question is found by looking for color.diff.<slot> in
"git help config".
