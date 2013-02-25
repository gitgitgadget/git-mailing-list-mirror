From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.8.2 l10n round 3
Date: Mon, 25 Feb 2013 09:45:04 -0800
Message-ID: <7v8v6cz3rz.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
 <CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA27J-0004c8-2X
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab3BYRpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:45:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab3BYRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:45:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6633AA156;
	Mon, 25 Feb 2013 12:45:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=HHzszs
	ICkuzKEmcI6khAKj89EtyqWhPLtfwZs5IVapIGdxuo9YbAKH0H7oQn6cfMHn7JLe
	xoh8r8gIoNExEbj0FZbVzOsF0IRw+cmwfkXe2uhD8n3g62HAg9aL1G8FkryKu0i2
	pTKyBWNC/6VteoGHNT5VFw7wvZ+oQvbUoXi/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPH028pg2pKDiyqfi06Tc5FPN6qViDyZ
	JLJPKVquk1KEUPDK/TaxItz0aM/rz0stlcfxtIFM4O4rldGHEqjy79uboSRllahH
	UQjkZ++6Nsv66oehpmtcypcI6Di6TAsd1r9g05MS6ZhEU6LrLX8eJ9LzSalNxjFY
	0sklHGiNI+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A2F6A155;
	Mon, 25 Feb 2013 12:45:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D305FA152; Mon, 25 Feb 2013
 12:45:05 -0500 (EST)
In-Reply-To: <CANYiYbHPtW0u80ojHt9xoADVS8S8mVkubb6dUDN_1uwkcTZTww@mail.gmail.com> (Jiang
 Xin's message of "Mon, 25 Feb 2013 21:24:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17055D96-7F73-11E2-B77B-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217069>

Thanks.
