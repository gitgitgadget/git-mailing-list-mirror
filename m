From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 1.8.5 round 1
Date: Tue, 12 Nov 2013 11:26:35 -0800
Message-ID: <xmqqk3gdh15g.fsf@gitster.dls.corp.google.com>
References: <CANYiYbHjAtgeFAHwq3rOz8CN1CQ_PLFkoMYNA-TGKqjDytc-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Sebastien Helleu <flashcode@flashtux.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Tran Ngoc Quan <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 20:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgJbo-0006Vq-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 20:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab3KLT0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 14:26:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab3KLT0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 14:26:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76E2F52CCA;
	Tue, 12 Nov 2013 14:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTg6M9tyEzkrhuE1ryzdOKxRs2E=; b=djtAUc
	HgpeJXhbKfRC1HOYNzXCKJ8WMUT6SBf6HWapx17WVa/ElLQui6JVmh5YYddxehng
	DLZJaYGvEnKGk50pNm8P6O8EfUgge9v5icH/+edf9plaDQ5xvFQpgLfxcWpd9bSE
	i7mcH2gBFCg44LtU+O/dV0L+VJOcX6SN93mSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sDjvwZlJqulOdlD8wzOouYeJftkxJ7Oh
	kYsjs1wOKxxYsXCksK6Po5/a6szMvtY7hFHMiKL6mq+zN6KP4O9bi0uJmUvqG+h2
	Zl1Hzi64r03GrrOrgibvpiLy4wF1VdfWDTxamUj064aOhHAgzS7mUynofvRSvZ3d
	LpyTpmcdZsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685E852CC9;
	Tue, 12 Nov 2013 14:26:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A94B352CC8;
	Tue, 12 Nov 2013 14:26:37 -0500 (EST)
In-Reply-To: <CANYiYbHjAtgeFAHwq3rOz8CN1CQ_PLFkoMYNA-TGKqjDytc-Qg@mail.gmail.com>
	(Jiang Xin's message of "Tue, 12 Nov 2013 15:23:28 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 597B3ACC-4BD0-11E3-82B2-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237729>

Thanks, all.
