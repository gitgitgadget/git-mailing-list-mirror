From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-l10n updates on master branch
Date: Tue, 12 Jun 2012 09:23:06 -0700
Message-ID: <7voboojy8l.fsf@alter.siamese.dyndns.org>
References: <CANYiYbF6-oDagBD04Cf7X2EOYPMFMydJ1a2QQfbxcWgL3=cb7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>, Riku <lu.riku@gmail.com>,
	Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 18:23:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTsB-0006oN-Af
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab2FLQXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:23:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab2FLQXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:23:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10C198E0E;
	Tue, 12 Jun 2012 12:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=ShcS5b
	wS7WUsSnGLhzP+B9/OQPoMt3UhtMGUethwu0YuCKx86zg99/UI+n39uMM4cbviKp
	Vgtye9UUs+dckxaTTH93czqJb60QIKD2bOCeH4p3DLQwh53Srbw5Upm1nOoZhW98
	8iJTHUyfUcNMF82Je5qeDBJB9pjsImBIfy3m8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDWmM7lz2bRAz3TZF2KFCjG5vSk0aNoQ
	RmeOQXxro++DZ29aUXGJpRc8OUZKRE4FJprvmxO4xNJqlYI2pjdNxnLe0pqS7N4c
	H04cv0ZkeluqRciugFTZhNy5kOMJQ79zPwBecI/iHdN1i9fkq4a2RVOmlBVeHp1Y
	kNBB0Qmzlk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 063EE8E0D;
	Tue, 12 Jun 2012 12:23:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 874118E0C; Tue, 12 Jun 2012
 12:23:08 -0400 (EDT)
In-Reply-To: <CANYiYbF6-oDagBD04Cf7X2EOYPMFMydJ1a2QQfbxcWgL3=cb7g@mail.gmail.com> (Jiang
 Xin's message of "Tue, 12 Jun 2012 23:59:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E58507F0-B4AA-11E1-BFD6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199809>

Thanks, pulled.
