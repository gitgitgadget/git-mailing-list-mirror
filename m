From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull l10n updates for 1.8.2 round 1
Date: Sat, 09 Feb 2013 13:44:01 -0800
Message-ID: <7vd2w9w4bi.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHhGDFD3LZKGeRxkBF5s0TRHMvRBZY7c9T8zONiZGiNdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Wang Sheng <wangsheng2008love@163.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4IDv-0007Sn-Hl
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 22:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab3BIVoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 16:44:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569Ab3BIVoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 16:44:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD4D8C231;
	Sat,  9 Feb 2013 16:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=b5VBZt
	UY4cK3i+MwqbCGqN5ysjB//MAs7e2zxQ2qjKNxVJEctZjweumQAKBxgJGDsIJryo
	Z8C2Seu0STptRloySsEBYg20jjieohSG5a4cO9crr5Oz1Uodu3nDzPu20J5I/2CP
	BVC+3IdXWR3WSCYmrrOvGLfsIHYorUz7M8Q9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TaWhaIISZsFbz3TJ+HQXsUSdsvC5HlMY
	tPBmVPhaWM1mPqgprCaIBKkLAwseRVjp7SbWvZiWv+DXTi4E9R25lTMlL+yJmqbb
	4x7FVEHUwDc86m1lawdQCSwrYSYqDeQQQKSPEbFhAFfQ1OdkiFOFOjyXlHQIMzMZ
	+aKZfRm7y7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92625C230;
	Sat,  9 Feb 2013 16:44:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14248C22E; Sat,  9 Feb 2013
 16:44:02 -0500 (EST)
In-Reply-To: <CANYiYbHhGDFD3LZKGeRxkBF5s0TRHMvRBZY7c9T8zONiZGiNdA@mail.gmail.com> (Jiang
 Xin's message of "Sat, 9 Feb 2013 11:55:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D20F519C-7301-11E2-B80F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215872>

Thanks.
