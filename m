From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5/RFC 0/6] Moving gitweb documentation to manpages
Date: Mon, 10 Oct 2011 11:47:23 -0700
Message-ID: <7v39f0lg44.fsf@alter.siamese.dyndns.org>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:57:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMuY-0002fi-S9
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1JJU5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:57:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab1JJU5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:57:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9562C47AD;
	Mon, 10 Oct 2011 16:57:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=2pGbsRbuZ2igeBYRyltQT8DrjG8=; b=X4uPLZz7HwiaWWBBdG2s
	a7qA2bYDQL1B8awEBoKl8rV8sdwLCSLV8YM8NxCqw4Pg9oNCWF+ganQZcFW++slm
	aa6KeHMEAY5uqtEkwrwC8LzsdaQZuc5r4yDeaKCAQB/FZEOEuSq9YzSP518fKNQJ
	IfW5XfWZvEcHIAddDw5cxa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EEXCHKit6XZCgSyTl7zaeqz9w0tTIAieuHP/iyHUQslkjl
	NVKlHbNSF60E14Af6dB0OCxo78Lm0iRVMHqkAb8o0o0OPciHrf5NP59BOZybVtU5
	pwMo/pE6gYRxCDYsxnKjYchUtPWzCFtC33uytLyCuf7E6OMKbFm0DjBZrOAyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE0847AC;
	Mon, 10 Oct 2011 16:57:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D40F47AB; Mon, 10 Oct 2011
 16:57:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FF3CEDE-F382-11E0-8BC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183255>

Thanks for working on this.
