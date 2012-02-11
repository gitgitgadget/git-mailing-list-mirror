From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Sat, 11 Feb 2012 10:03:47 -0800
Message-ID: <7v8vk9mem4.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Sat Feb 11 19:03:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHIh-000185-40
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 19:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab2BKSDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 13:03:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab2BKSDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 13:03:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7DA6C53;
	Sat, 11 Feb 2012 13:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BBaKLJTOhF2J419ZmC/134aqx4U=; b=CN0wF7
	IMWddRuaren5YNHCALpQ3/QqfPL3KjsHU4Yn/DwR4ZdGUY7Bxuu3TeRlaSEZ7Ve7
	amKity7modzQoWf2HXX7rUGkpCi9cEKKpWVBFjU3fX8iv5jSfZJ70iKPOe4noes6
	FbCoQffCXDGwMmQZOMBLFFwZxVX60vYIFfWKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EG7RE+uiRJF3ZBST4tVKVNOEpuufTTZ2
	VVpbs4jF7GEuHS/9M880pNf04ocApFTFB2lCZZo+T16I7SES9njl3x6KGEh1kT/7
	/0asp6ssHlhv1vbx24czNf5nZ22biPrTyVsygphbV4MkIrLuudHsMeozk07YQuc2
	oHqt4THuBgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 056AF6C52;
	Sat, 11 Feb 2012 13:03:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8522E6C51; Sat, 11 Feb 2012
 13:03:48 -0500 (EST)
In-Reply-To: <877gztmfwy.fsf@smith.obbligato.org> (David A. Greene's message
 of "Sat, 11 Feb 2012 11:35:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF381D42-54DA-11E1-A7C9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190522>

greened@obbligato.org (David A. Greene) writes:

> I might need to fiddle with permissions, let me know.

Everybody's client can talk smart http these days. Please don't
host/publish the code behind a dumb HTTP server.
