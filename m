From: Junio C Hamano <gitster@pobox.com>
Subject: Interested in helping open source friends on HP-UX?
Date: Wed, 10 Dec 2014 23:46:25 -0800
Message-ID: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
Reply-To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 08:46:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyySG-0004eL-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 08:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933961AbaLKHq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 02:46:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933943AbaLKHq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 02:46:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B0FD1D596;
	Thu, 11 Dec 2014 02:46:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:reply-to:date:message-id:mime-version:content-type; s=
	sasl; bh=6xUrCebrHycxw2t/4EY7LkYL5PM=; b=j09lGBCwC0iHYW5b7qGZx6p
	U+AjS6FA7b4c1bPNbq+xhqeQ/rdsP8jwThXU08b52YVwO6eYLluYB1II/0dMhLob
	O2bmchn4nOLFUSLxjOaDxemiTkkzS60+enslzohwDOBvs8xHgKfuepvSd/554RPn
	Jxhp80C9b5RYNt16sbjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:reply-to:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uyDG63vFr6gpYXMI0jOPfntjRqwP9ciEe6avX/Zzsh7QCTuMx
	AIvXWSEcmJQ2e9qWBZZS11FLeSPaww76By7mNh/pvEQD7XUp8U3ZF5gKIYkICP+o
	MgYk6jxPFyaSHKI/uc9ND2pV+e732yJBMwDmGv4Qv/Qi/PybdZbA37axmI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B071D594;
	Thu, 11 Dec 2014 02:46:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4A651D593;
	Thu, 11 Dec 2014 02:46:26 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFC2EE40-8109-11E4-8801-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261272>

Hello, all.

H. Merijn Brand runs a few HP-UX boxes to help perl5 and other open
source communities, wants help porting more recent Git on these
boxes, running HP-UX 10.20, 11.00, and 11.23, and looking for a
volunteer.  Please contact him directly if you are interested.

Thanks.
