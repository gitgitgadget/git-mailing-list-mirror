From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-mediawiki: update comments to reflect
 credential support
Date: Sun, 08 Jul 2012 19:17:16 -0700
Message-ID: <7vd345n0er.fsf@alter.siamese.dyndns.org>
References: <1341764308-9508-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 09 04:17:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So3Xu-0002gg-07
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 04:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab2GICRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 22:17:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab2GICRT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 22:17:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E78959DCE;
	Sun,  8 Jul 2012 22:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FOl/k/4HT7zdXRh3fZJPlowZ+S0=; b=qoSvo+
	CVwG0No6pa8Jdc9oD5TT4doGVQOOfdF8jqgZxVdqJ1dZimYOJ+JHjafTKRd8Ddl9
	R+L/7zkNWszh3XSdPZegWBi+dWbL0ymsn5olmMicPROhsJIJmpD5s/MP51a9i59n
	nz0NF88JSplyYg++L6QV+D7nCxJlTPhCojICs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLc44lKWpHmXE3PkKHJ8pTleXykvsXVf
	qikapoURXk2ycwwtLWSKj/bBxCeewVBRgq26hrKxYC8uca7SQhBvQkTr03DXXmo4
	nN8PecLfHKxyrlRSoFfTplVFsQ0EiIVmhIoMhGWXnFuL8HG1idMm+emRObYaxnSY
	iewewrhImSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE9A9DCD;
	Sun,  8 Jul 2012 22:17:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A3329DCC; Sun,  8 Jul 2012
 22:17:18 -0400 (EDT)
In-Reply-To: <1341764308-9508-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun, 8 Jul 2012 18:18:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3539C83C-C96C-11E1-8F14-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201189>

thanks; done.
