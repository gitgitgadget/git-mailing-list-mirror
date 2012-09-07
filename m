From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Fri, 07 Sep 2012 10:27:09 -0700
Message-ID: <7vsjatyc9e.fsf@alter.siamese.dyndns.org>
References: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA2Ku-0005n5-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2IGR1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:27:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab2IGR1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:27:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D59DB7F43;
	Fri,  7 Sep 2012 13:27:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ByWU0E
	H6y+/h9b8hllgcvPK99WP/dgUNfL8YNZQP8mtGcuIZKXRrK6FWyAZOMOKwtYlwGb
	PlbQ2cagRY2pNWgA5fM7f5CNZXyZXUCAifuN+kL3Mbs4dhDP4Y1ocgXyl+zX0A1a
	FolUwDVHhSWRieMtilLFCqqdA3I+Zql7xst2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=blPDiu4IltnixGIRBPUMtzynYxlrkRuC
	VuFv1t3DU+kJHJPLHUqcshOdbFQONnef2Do8hiPyasMcugibIr+guIaHZ/rQ1OvS
	pYOtMRw+FmFViUru3ED6e5QPOw+LmoiNxX4vtyEDFHJ3Na+wV+7iZkpJKBQkiwQ8
	iyZedOzLgZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C068B7F42;
	Fri,  7 Sep 2012 13:27:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B6047F41; Fri,  7 Sep 2012
 13:27:11 -0400 (EDT)
In-Reply-To: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 7 Sep 2012 14:10:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41D1C840-F911-11E1-9708-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204980>

Thanks.
