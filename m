From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add per-svn-remote ignore-paths config
Date: Sun, 12 Apr 2009 01:29:14 -0700
Message-ID: <7vskke9sx1.fsf@gitster.siamese.dyndns.org>
References: <1239471978-45479-1-git-send-email-ben@ben.com>
 <20090412005901.GB10656@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Jackson <ben@ben.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 12 10:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsv5c-0004R7-FI
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 10:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbZDLI3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 04:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbZDLI3V
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 04:29:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714AbZDLI3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 04:29:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F1F8E016;
	Sun, 12 Apr 2009 04:29:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A7979E013; Sun,
 12 Apr 2009 04:29:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04681EB4-273C-11DE-A295-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116373>

Eric Wong <normalperson@yhbt.net> writes:

> Ben Jackson <ben@ben.com> wrote:
>> Signed-off-by: Ben Jackson <ben@ben.com>
>> 
>> ---
>> 
>> This version fixes a bug found by Eric Wong (inappropriate cut'n'paste
>> use of perl m//o) and extends the test cases to include independent
>> tests for command-line and config ignore-paths.
>
> Thanks Ben, this series acked and pushed out to
> git://git.bogomips.org/git-svn.git

Thanks, pulled.
