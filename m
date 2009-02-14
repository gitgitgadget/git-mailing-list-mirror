From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Clean up use of ANSI color sequences
Date: Fri, 13 Feb 2009 23:53:24 -0800
Message-ID: <7vocx5xxmz.fsf@gitster.siamese.dyndns.org>
References: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
 <1234562021-2397-1-git-send-email-arjen@yaph.org>
 <7v4oyx4vxw.fsf@gitster.siamese.dyndns.org>
 <20090214074134.GC10795@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Sat Feb 14 09:06:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYFWb-0005Bo-9f
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 09:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbZBNHxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZBNHxd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:53:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZBNHxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:53:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 645EF2B18F;
	Sat, 14 Feb 2009 02:53:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A262F2B18B; Sat,
 14 Feb 2009 02:53:25 -0500 (EST)
In-Reply-To: <20090214074134.GC10795@regex.yaph.org> (Arjen Laarhoven's
 message of "Sat, 14 Feb 2009 08:41:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9161F328-FA6C-11DD-B246-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109842>

arjen@yaph.org (Arjen Laarhoven) writes:

> On Fri, Feb 13, 2009 at 06:02:51PM -0800, Junio C Hamano wrote:
>
> [...]
>
>> These four are obviously bad and not even compile tested.
>> 
>> I'll fix them up when queuing.
>
> Grmbl.  Note to self: never patch and watch TV.  Sorry about this.

That's Ok, mistakes happen.  And I sometimes watch TV while my machine is
doing all the work for me ;-)
