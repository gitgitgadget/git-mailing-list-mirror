From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/9] Default pager and editor
Date: Sun, 15 Nov 2009 01:04:51 -0800
Message-ID: <7vk4xsrwek.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b2x-0000fV-FY
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbZKOJFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbZKOJFH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:05:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbZKOJFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:05:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C975B991C6;
	Sun, 15 Nov 2009 04:05:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/Y+hsABescsNVwgAwwHJdEQx+dg=; b=cWGhQwQaujVjCxfCGTZ1NyJ
	U0P0syGvVBPRfHAKtcdz8E42NXZSJpa8vW8ssoRWiwjzobT9VwnPq7V5KPt0VqQF
	ubCsSWX1kEZCOMbxDJ+AFaQ3/u79WliBS9XAbJ71YRHhjK4pI//7JTDij+gyl39P
	zasIM7ZBLi7IZByiO1ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=A4ti27tlbZ1DgCfEwF8lAi337+bRU0NlBAfrsntSJbWFlzOMj
	pgYDMPik8in8Xn+kkpvDHX1+NLJ+VzykoW/bMYQvCBUwge7tEpXzk+CzQMwcZ37w
	UtDJT8e42Ho8h57hWCcow0lLNO9nYPX0wZMS8poODM8dZhj2Vo6OHwk1yI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76F4F991C3;
	Sun, 15 Nov 2009 04:04:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C869F991C1; Sun, 15 Nov 2009
 04:04:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3A9AEBE-D1C5-11DE-91A7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132915>

Thanks, re-queued.

I've been sick and in bed for the past few days, so apologies for a late
reply.
