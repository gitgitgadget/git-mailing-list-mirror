From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.1.0 round 1
Date: Mon, 25 Aug 2014 15:41:30 -0700
Message-ID: <xmqqzjesjip1.fsf@gitster.dls.corp.google.com>
References: <CANYiYbGwXujdPg1fQWjvWjzQ41D+v-xA_ty_MqC2FtTRjGRJYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM2xP-0003M5-40
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 00:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbaHYWln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 18:41:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57533 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbaHYWlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 18:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8B9735F8A;
	Mon, 25 Aug 2014 18:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jVdYpWHV/G1WtWPMq9IRTQgmVb4=; b=k8Ry79
	VGm8+mQ6PGvBAc6XR/u36PtM42YgT0klFRcK4M5BrHiwvGadN8v1hqMVXd6o+r2a
	uFXtEV+yk/uusXN8LHxEtb77nmpPbjsUm1Gk50XC9/vVM2jSe6CF7oYy3tU1iFW2
	CpdCPv0IpfxqhdogRKmZizcMAoWynH32BWHjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nms9fg8Jx16Bix+aQMYp8PDn1+qt5cFM
	uDgW/EMOLOZUk20I6Gvu1h+Jdksar3VRMPjn9fXF0cFp5AFjiMEmAmIBKwBxcheK
	ODHj5ANC8TQ2ggtCSunwvQfjQIPUEAhMv8O1LVhQsOG0n9KQeTOhCw741VIlVUwo
	6622X7nb5nw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD1F135F89;
	Mon, 25 Aug 2014 18:41:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B21535F83;
	Mon, 25 Aug 2014 18:41:32 -0400 (EDT)
In-Reply-To: <CANYiYbGwXujdPg1fQWjvWjzQ41D+v-xA_ty_MqC2FtTRjGRJYg@mail.gmail.com>
	(Jiang Xin's message of "Sat, 16 Aug 2014 19:05:03 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F61D48A2-2CA8-11E4-B1BA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255874>

Jiang Xin <worldhello.net@gmail.com> writes:

> The following changes since commit 49f1cb93a2f11845cfa2723611a729d3d7f02f0d:
>
>   Git 2.1.0-rc0 (2014-07-27 15:22:22 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po
>
> for you to fetch changes up to f7fbc357f863ecc5323f3fcf2fc9cbf2aa2a8587:
>
>   l10n: fr.po (2257t) update for version 2.1.0 (2014-08-07 09:07:18 +0200)

Thanks. I finally got around pulling this one.

Sorry for the delay.
