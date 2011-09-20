From: Junio C Hamano <gitster@pobox.com>
Subject: Re: maybe I missed the announcement, but...
Date: Tue, 20 Sep 2011 12:51:57 -0700
Message-ID: <7vipon56w2.fsf@alter.siamese.dyndns.org>
References: <8639frs3bf.fsf@red.stonehenge.com>
 <1316528864.8701.17.camel@centaur.lab.cmartin.tk>
 <86pqivqnzw.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Sep 20 21:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66MP-0003KK-91
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab1ITTwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 15:52:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab1ITTv7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 15:51:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C9C40B0;
	Tue, 20 Sep 2011 15:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V2wj1ifdHKF7
	AccNZlur93/iyYY=; b=YgTztrUpj6Awul0KltjWCS+Yvhm0aipPPoxlHRmb5pru
	3bDkKQ0+97rCpIApPsypmwi/JZRv+XFlHYPvf5obZrUTj9pfNHzW8gE6KNo0BAhV
	ZoDeKKz+//vQELR1RNiYx5a219hvgBd4kXbg12IA+Ya0q3zjAq1hJsrrFtUrNvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K1c1ed
	xE9NebLI7/YzBvdaUIMt1Ms2xa7tkWKUlT6uycQCJywKoJJDUrba/Ju7cLi/ii/o
	kMTFZbKItTZjGKZWkpjGVp3atio9lEpcwQ7/7Dm6UKH+fYRIiNEY6hENzp3CL0DC
	4b51f8LIqZHIhHQlebJCQueDKzwPF58GD1WtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B70040AF;
	Tue, 20 Sep 2011 15:51:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C68D640AD; Tue, 20 Sep 2011
 15:51:58 -0400 (EDT)
In-Reply-To: <86pqivqnzw.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Tue, 20 Sep 2011 07:36:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 003C6D5A-E3C2-11E0-9311-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181786>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Carlos" =3D=3D Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
> Carlos> From Junio's latest "What's cooking"[0]
>
> Ahh, the famous "buried lead". :)

Did I do anything wrong to "bury" it?
