From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: do not misinterpret pull refspec as bold
 text
Date: Fri, 03 Dec 2010 12:56:08 -0800
Message-ID: <7vk4jqo9sn.fsf@alter.siamese.dyndns.org>
References: <20101203200417.GA15300@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcg3-0000S6-IX
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000Ab0LCU4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:56:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0LCU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:56:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 771CF33C4;
	Fri,  3 Dec 2010 15:56:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=UiU9b6
	dW61JQqSmJJO+j/Mqui+KwYsb+rW+DYbJpu63eWOg4RU3hJf44Ximst4mJCMY3az
	O68teSUBLElH+YrfygabRPYWAjN1SmH2FvIrYX5gCpq03pqQLvdw2LAFukqoTVOK
	dlSyXYomUTAJ2NBzJtFiFCUyA847Fav0Orf9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jR1vqbnznDUqDUELuVi7Dzt9x2fDXNs6
	hqofiXEvZxBEx1nFuE8+jWYT0OHjXaAVxGLY4efwSvE78jQlRhubrwaw/x94NcZR
	3iq2B8NKrmjca6+eYnuOjnFNk6ZGBTapWxjrPoBnnggU7AUl7bRZIKDnm88+nyE8
	mqG+elDg204=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B56933BA;
	Fri,  3 Dec 2010 15:56:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4193033B9; Fri,  3 Dec 2010
 15:56:29 -0500 (EST)
In-Reply-To: <20101203200417.GA15300@burratino> (Jonathan Nieder's message of
 "Fri\, 3 Dec 2010 14\:04\:17 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF4C7C3A-FF1F-11DF-A1A6-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162851>

Thanks.
