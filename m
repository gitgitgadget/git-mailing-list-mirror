From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: fix broken symlink workaround when switching
 branches
Date: Wed, 11 Feb 2009 10:41:12 -0800
Message-ID: <7vmycserzr.fsf@gitster.siamese.dyndns.org>
References: <83dfc36c0902101438p7b7fbff8ja66b1fb021942cd8@mail.gmail.com>
 <20090211101207.GA28840@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Gyllenberg <anton@iki.fi>, git@vger.kernel.org,
	gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK2t-0005rF-4s
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbZBKSlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbZBKSlV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:41:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbZBKSlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:41:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DE462AEBE;
	Wed, 11 Feb 2009 13:41:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DAFC2AEC3; Wed,
 11 Feb 2009 13:41:14 -0500 (EST)
In-Reply-To: <20090211101207.GA28840@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 11 Feb 2009 02:12:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 927AB5EA-F86B-11DD-BD15-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109494>

Eric Wong <normalperson@yhbt.net> writes:

>  Thanks Anton, I've made the following patch along with your
>  testcase and pushed to git://git.bogomips.org/git-svn

Thanks; I'll pull.
