From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/16] setup: trivial style fixes
Date: Thu, 31 Oct 2013 13:48:57 -0700
Message-ID: <xmqq7gct4152.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-16-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:49:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbzAv-0005Pi-0z
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3JaUtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:49:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab3JaUs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:48:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3F74D636;
	Thu, 31 Oct 2013 16:48:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gzkU9xnzlK2zG2DoUxvQWvMx4jU=; b=SpSAsy
	RlPlUytAhdoAU+f9zEE0IVcxC+22N56DMqlUH8w774+hjsW3Rm1AlEzLJWt1JW3Q
	mnq/Gs1cPdyb3JFlDn9LXh4f3Ar3Wc9PzSIa5LajGx8EptMIMSXVpIylEQAnE14A
	i+LxVa0j9+nlvdNG84sUh5c09AbUAf8enL5Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AiuJ6fC/nvPigSgpa9znsCXkCOvHYyr0
	damBVpGqUFJTBao1GzJOonvLmWdAShaz3rNp+y53bY5+1VfdZdlifXns1nds9OLE
	WLJCoysu9l/nggWh2B/felJsbdAXT9+xywrw1gg6/TJbFXv2h5TY1e3QDiKbrzqg
	VMbnfQTMnvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C6C34D635;
	Thu, 31 Oct 2013 16:48:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E8A4D634;
	Thu, 31 Oct 2013 16:48:58 -0400 (EDT)
In-Reply-To: <1383211547-9145-16-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:25:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD748110-426D-11E3-86EA-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237182>

Patches 7 through this one looks good; thanks.
