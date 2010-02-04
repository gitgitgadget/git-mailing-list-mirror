From: Junio C Hamano <gitster@pobox.com>
Subject: Re: faceted search interface
Date: Wed, 03 Feb 2010 17:31:07 -0800
Message-ID: <7v636d3hyc.fsf@alter.siamese.dyndns.org>
References: <E1NceXz-0003VA-QG@mail.chiefmall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Ksikes <alex.ksikes@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqYz-0006w2-27
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053Ab0BDBbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:31:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991Ab0BDBbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:31:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C495097E7F;
	Wed,  3 Feb 2010 20:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YQYJJUQhfELhPb993EaR5mSuhog=; b=xu5Aop
	myCnREX1w4qV+hTqdW5p3NFISgkL/hP/JaZCluiyJB8Gjr9KMMXkB0piVlOElhHW
	9pt//mliaRG4HhK161Ki+oRso9hr35fwELT994QJKsLuErg3zDmvD9pnfQTsUIFf
	PU0trxxQbMNHae0mpt/A9hs5Sb9TQ09eylFU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrD6OnV0yuOLNWCNl4ejrQi1ewKYTpwT
	l4tekx1nP/eZbeg7kKl0KOLTtkSXv5k3saxiThTL9wW3kcBURBvjRsFyHNxd/ara
	NX9xC3lve707tv5wHuIdaN3SgWvHqP33ikEg92QdwaRoTpVd3optjujnObtHWtL1
	MD5O+4HgvYo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A085997E7E;
	Wed,  3 Feb 2010 20:31:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0395797E7B; Wed,  3 Feb
 2010 20:31:08 -0500 (EST)
In-Reply-To: <E1NceXz-0003VA-QG@mail.chiefmall.com> (Alex Ksikes's message of
 "Wed\, 03 Feb 2010 04\:41\:31 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA149B82-112C-11DF-B245-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138926>

Alex Ksikes <alex@chiefmall.com> writes:

> I have just put together a system to automatically build a faceted
> search interface and search engine from any data. Would you mind having
> a look at it and letting me know what you think of it?
>
> Here is a particular instance on IMDb (the internet movie database)....

The query system might be interesting, but what does this have to do with
this mailing list?
