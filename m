From: Junio C Hamano <gitster@pobox.com>
Subject: return of the maintainer
Date: Mon, 14 Oct 2013 10:37:47 -0700
Message-ID: <xmqq1u3nhhxw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 19:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVm5b-0002jZ-7D
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 19:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3JNRhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 13:37:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343Ab3JNRhu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 13:37:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F214A328;
	Mon, 14 Oct 2013 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	tWOnBAh7uNfFnvLTNyMehxpzuU=; b=kjOfdLRl8zSoKyCq2HTyFo69OqzRG2T7V
	xxqn5qubpNJzjCtwsbX4dF/1Crf5gJ+v8/Kfq7sOtmBAqzLwhu1P3TBiz1cjUPSc
	64pr4AVy05UurrAf6kqk8gMiXKUDuT3uDhkp/V5r3tskUv5dPqFs+4V5prx1VB4P
	LOlCKALdnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ic8
	OTPboU7RqdzfQecoWCqEcDXtU7olJa41iSgoEUD9gk5FWdMIHHOPqHZao2KMGbM1
	sOpunviqLpyjjAlrnL3lnjEH6wZwEUBw6oVw3kdYcGp9w1lTvGKFYT9GUuMeQMvg
	qrNN8cFKXRC8+cpLaRP3v1E7qcnSS0ki+4Mt8bBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49964A327;
	Mon, 14 Oct 2013 17:37:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CB004A31D;
	Mon, 14 Oct 2013 17:37:49 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58335B12-34F7-11E3-9391-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236108>

I am physically back to work, but I'll have to coordinate the
hand-off of topic branches updated during my absence with Jonathan
before resuming to update my git.git repository at kernel.org and
elsewhere.
