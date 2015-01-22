From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.3.0
Date: Thu, 22 Jan 2015 13:45:41 -0800
Message-ID: <xmqqr3umsd4q.fsf@gitster.dls.corp.google.com>
References: <CANYiYbFJfx1Sc+ync-Np11qBV6Zb3_mZFPaiQw5EwVa=3TG73g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 22:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEPZk-0001lh-QC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 22:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbAVVqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 16:46:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752135AbbAVVp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 16:45:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 407FB31C3B;
	Thu, 22 Jan 2015 16:45:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTg6M9tyEzkrhuE1ryzdOKxRs2E=; b=prSWDA
	p8qfK68dbKUblyi4lUer381MjHyQfRveUvYy+ro/jjettLGe6bqilEuwMdRHnDfX
	AVXKOvSvLrmvUBFHThsyLg+rXkUYgmscb7vhf96pxHeePacbrpKk6fEyEkJEI5aY
	zq0vuSwRD1lVs2GVgbl9f61xbzCNNdJNn5URU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xdt0ePBl2G+INtnJ3u2KyHM4ST4JVKNh
	N40gFcqYFf9Yiq1dvLPVpymHjh1VZBs9De0Xe8Q/jh3iF4yD+ThDK3Dd1aui1Qzp
	nFyJuwz3CinheCyv0dDuVr7t0YY6Olk/QYt9hAotwPoXA9y6pPI38iH0kKY6mTf0
	R31P8CWMigA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 371F331C3A;
	Thu, 22 Jan 2015 16:45:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB6131C25;
	Thu, 22 Jan 2015 16:45:42 -0500 (EST)
In-Reply-To: <CANYiYbFJfx1Sc+ync-Np11qBV6Zb3_mZFPaiQw5EwVa=3TG73g@mail.gmail.com>
	(Jiang Xin's message of "Thu, 22 Jan 2015 23:21:28 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03850DA2-A280-11E4-9C73-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262873>

Thanks, all.
