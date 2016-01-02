From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] German l10n updates on Git 2.7.0
Date: Sat, 02 Jan 2016 11:31:04 -0800
Message-ID: <xmqqvb7bpymf.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbGd4cZLnDQdOjbzehOeJEeu_ZyTwyyYsD_=ghGzHHqh1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFRtf-0003hK-MW
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 20:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbcABTbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 14:31:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751688AbcABTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 14:31:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 172DD37B38;
	Sat,  2 Jan 2016 14:31:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=qUXT7K
	sEf/ZdRLu/Ffs62RXAg2f0caXtuldUkihjOhEB+e/HYCkESNDh5PHH7gtOVq9a8y
	+mwZcIIjkPxE9wgeSkE46XwoU/1mAyMeH0qBelZNnoVDgnDylN9Wl0D4KInoErd6
	lwt0Qq+pM0q4MRZvO7tFersxCSysawNhb/iDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBXwUpvVLGYDI+LnIxQAljFEioOv+x2K
	9LG6lfzFPhLx9Gh8yQ06Gv5CNBNDEIccy+nGBF5vjpLH2pbI+KTw6uAosOu7BuKk
	VNdI2vwmowOU8zdxfS7XNtgPTrGeuGRzvF45wU/O2VkV2xqO/x6X81ATykhrS827
	MEaMKwTD7lM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DF9537B36;
	Sat,  2 Jan 2016 14:31:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 70B1937B35;
	Sat,  2 Jan 2016 14:31:05 -0500 (EST)
In-Reply-To: <CANYiYbGd4cZLnDQdOjbzehOeJEeu_ZyTwyyYsD_=ghGzHHqh1Q@mail.gmail.com>
	(Jiang Xin's message of "Sat, 2 Jan 2016 08:53:15 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DA95B14-B187-11E5-894B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283264>

Thanks.
