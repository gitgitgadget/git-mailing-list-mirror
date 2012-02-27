From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] CodingGuidelines: Add a note about spaces after
 redirection
Date: Mon, 27 Feb 2012 12:55:44 -0800
Message-ID: <7vvcms573j.fsf@alter.siamese.dyndns.org>
References: <1330125178-9194-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S27bt-0001DL-7s
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab2B0Uzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 15:55:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2B0Uzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 15:55:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81AE067DC;
	Mon, 27 Feb 2012 15:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F9TbBcSx8TNN6R4ea8d/ypXTeQ0=; b=hMPoN0
	Jb7ib1rtFAViWYsfbCbJxaKcirJ6FNwz+r72c7AzODR3tSbhWCyiy9tWjsvkklAJ
	NmSMlOpsxePLF6Mr3YySxj3GbHW7skgzlQdZxfAmqo06yKOz1VjozIwofM8x9FjA
	2Uinqcn1ciEodP9/Mu/NDS4BTq4UVMmJgCee0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+0DJk+ck9+0L0U8H2nS+kDQ3NcAjH/3
	C38qjKayDhkahpUwaeRmrc15giuvXO/9hIdNrVjXi57P6J5K2/K+Kh18skYUXRSj
	I8Mas8PPuY/qlub4ohS6Hf45pZzxggWeRBLp/9LWv/9jC23PcKhPRHPkJGsjGe++
	wu94tkoZ7TY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DE467DB;
	Mon, 27 Feb 2012 15:55:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 134D067DA; Mon, 27 Feb 2012
 15:55:45 -0500 (EST)
In-Reply-To: <1330125178-9194-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 24 Feb 2012 18:12:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B8EE682-6185-11E1-8019-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191669>

Thanks; will apply both.
