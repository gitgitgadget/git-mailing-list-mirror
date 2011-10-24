From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reindent closing bracket using tab instead of spaces
Date: Sun, 23 Oct 2011 23:56:21 -0700
Message-ID: <7vmxcq514a.fsf@alter.siamese.dyndns.org>
References: <1319430291-12612-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 08:56:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIESU-0005Vb-OS
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1JXG4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 02:56:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab1JXG4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:56:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B5D42677;
	Mon, 24 Oct 2011 02:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=K/EqUY
	kBrVvtEXN7GZhclBVv+J7w+BKfnht6Sy5nx17hbfuPK2+O/q2byN8Kpna9kmTsWc
	Y+3y2JKq7q8r2Fl0Q3L9RAo8PZN+hXiyMpDT/AnCV6Pz0BmtWSiZL+SCdw5vx7jw
	9DPzx25tVvPQm3OeGC+Gq6w0gRdWo0eTbR9tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+acF4XIxWsflS72Ujbp5XCVZXoCLrgW
	vd5sDzZDHE52fifS0aMjEv3bciy1AUMyKSBzmUidYxE5uGs0o3l3z6t2dMXS+dV0
	JQ/7XNbzDCxZo5Sg03qGAKrZIh3/PaqMwWIStEqh/zOtt6Hh6/9EDEKVphTaLmL+
	pOubsnPQE0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 927182676;
	Mon, 24 Oct 2011 02:56:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 239C72675; Mon, 24 Oct 2011
 02:56:23 -0400 (EDT)
In-Reply-To: <1319430291-12612-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 15:24:51 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48DC9D22-FE0D-11E0-82B5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184165>

Thanks.
