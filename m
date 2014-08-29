From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for Git 2.1.1
Date: Fri, 29 Aug 2014 10:18:36 -0700
Message-ID: <xmqqlhq76wpf.fsf@gitster.dls.corp.google.com>
References: <CANYiYbGV_CFAOHzrEvyr+juNd3XmB_5t_fhNdCMWsFQwnTrujw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 19:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPp5-0004lZ-A5
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbaH2RSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 13:18:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56959 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbaH2RSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 13:18:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C95563360D;
	Fri, 29 Aug 2014 13:18:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=KOEKqs
	l+7zzrCds0ZGPeUam7luC2CUb6DxtfQdG01hjASPevKG/4zmFYkQlTJD7N7OBtdM
	NuUVa5nm6CG9Jvlq1JpjnooQkEshE03JxiZmkwTd73HGp/ZWpflq3wvvG2GbtYBH
	1Dr+tNGlIGJri9Elc+crbDlWWv5SdYUJt/isU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vXvgoaHslDnIO7+XN9skVkkUws5P4Qpv
	x/6JUE4g8rRIniPR6Wd/YOs1GMpDj02j16DbGdpICOmyon3gjy9RJ6ZFfqBhQwUu
	NR2WMTLNEIZX9LUIsj/oLOXjNTS0Tpg58FqHUtct7o6legEsroEHXcNHq2yyw01w
	Q0rL0o3zTko=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFDAF3360C;
	Fri, 29 Aug 2014 13:18:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C793133608;
	Fri, 29 Aug 2014 13:18:37 -0400 (EDT)
In-Reply-To: <CANYiYbGV_CFAOHzrEvyr+juNd3XmB_5t_fhNdCMWsFQwnTrujw@mail.gmail.com>
	(Jiang Xin's message of "Fri, 29 Aug 2014 18:12:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83AB6F9C-2FA0-11E4-A5C8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256166>

Thanks.
