From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git svn dcommit: new option --interactive.
Date: Fri, 16 Sep 2011 14:08:10 -0700
Message-ID: <7vehzgdwlh.fsf@alter.siamese.dyndns.org>
References: <1316206921-29311-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:08:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fdx-0001yJ-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 23:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab1IPVIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 17:08:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab1IPVIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 17:08:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9489E5A44;
	Fri, 16 Sep 2011 17:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4HwpUaomCsTYcnha1AV9UGI40GI=; b=qXVcUm
	S1cg0qYBsYA22XyTNyXglgoENVjWnIama9bRQ3yGXTV6KEcKlrzb58Le0VBbjHkR
	B1DRdgZBnc+2nPDZojNatVca2IvGIUH5GHIMefK5+LpMY1upp4dk+si58DUVvekP
	OTkcO96AEn7sDUnRa8p5/+wvY6PHcUFlyzMQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eUd/F85yEGY96veG3T9vJs2AOlsUiQOh
	bH/chGneQYIQzETpPCNLZAAQGhcjV7juUldIirxe2SjEVOuLpkFglse+KKsnIJp/
	YCudoXjaeupitso90B09sCHph9DIpIYRXfe9w6chPQEU0xG37zk0yk6oaCHd5XZJ
	g0Kl0QMhyDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C32B5A43;
	Fri, 16 Sep 2011 17:08:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FF9E5A42; Fri, 16 Sep 2011
 17:08:12 -0400 (EDT)
In-Reply-To: <1316206921-29311-1-git-send-email-frederic.heitzmann@gmail.com>
 (=?utf-8?B?IkZyw6lkw6lyaWM=?= Heitzmann"'s message of "Fri, 16 Sep 2011
 23:02:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC7E7360-E0A7-11E0-802B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181559>

I am not accepting any new features at this point in the release cycle, so
please do not Cc me unless it is a patch to fix regression or minor
documentation.

Thanks.
